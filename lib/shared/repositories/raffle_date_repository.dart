import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_dates_facade.dart';

class RaffleDatesRepository implements IRaffleDateFacade {
  final cacheDateRaffles =
      CacheController<DateTime>(cacheBoxEnum: CacheBox.DateRaffles);

  @override
  Future<void> cacheRaffleDates({int month, int year}) async {
    //Toda segunda e quarta quarta-feira do mês tem sorteio. numeros de 0 a 99.999

    int wednesdayCount = 0;
    DateTime secondWendnesday;
    DateTime fourthWendnesday;
    bool hasSecondWen = false;
    bool hasFourthWen = false;

    //for pelas datas do mês
    try {
      for (int day = 1; day < 32; day++) {
        var date = DateTime(year, month, day, 18);
        //Verifica se é uma quarta
        if (date.weekday == DateTime.wednesday) {
          wednesdayCount++;
        }
        //Verifica se é quarta de sorteio
        if (wednesdayCount == 2 && !hasSecondWen) {
          secondWendnesday = date;
          hasSecondWen = true;
        } else if (wednesdayCount == 4 && !hasFourthWen) {
          fourthWendnesday = date;
          hasFourthWen = true;
        }
      }
      await cacheBigLuckyWendnesday(month: month, year: year);
    } catch (e) {
      print('ERROR!!');
      print(e);
    }
    await cacheDateRaffles.writeByKey(1, secondWendnesday);
    await cacheDateRaffles.writeByKey(2, fourthWendnesday);
  }

  @override
  Future<void> cacheBigLuckyWendnesday({int month, int year}) async {
    DateTime luckyWendnesday;
    int luckyMonth;
    int wednesdayCount = 0;

    if (month < 5) {
      luckyMonth = 4;
    } else if (month < 9) {
      luckyMonth = 8;
    } else {
      luckyMonth = 12;
    }
    for (int day = 1; day < 32; day++) {
      var date = DateTime(year, luckyMonth, day, 18);
      //Verifica se é uma quarta
      if (date.weekday == DateTime.wednesday) {
        wednesdayCount++;
      }
      if (wednesdayCount == 4) {
        luckyWendnesday = date;
        break;
      }
    }
    await cacheDateRaffles.writeByKey(3, luckyWendnesday);
  }

  @override
  Future<void> cacheNextRafflesDates(DateTime date) async {
    if (date.month == 12) {
      await cacheRaffleDates(
        month: 1,
        year: date.year + 1,
      );
    } else {
      await cacheRaffleDates(
        month: date.month + 1,
        year: date.year,
      );
    }
  }

  @override
  Future<DateTime> getNextRaffleDate() async {
    if (DateTime.now().isBefore(await cacheDateRaffles.getByKey(1))) {
      return await cacheDateRaffles.getByKey(1);
    } else if (DateTime.now().isBefore(await cacheDateRaffles.getByKey(2))) {
      return await cacheDateRaffles.getByKey(2);
    } else {
      await cacheNextRafflesDates(DateTime.now());
      return await cacheDateRaffles.getByKey(1);
    }
  }

  @override
  Future<DateTime> getBigLuckyRaffleDate() async {
    var date = await cacheDateRaffles.getByKey(3);
    if (date == null) {
      await cacheBigLuckyWendnesday(
          month: DateTime.now().month, year: DateTime.now().year);
      return await cacheDateRaffles.getByKey(3);
    } else {
      return date;
    }
  }
}
