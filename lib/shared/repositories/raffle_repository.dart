import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle.dart';

class RaffleRepository implements IRaffle {
  @override
  Future<void> cacheRaffleDates({int month, int year}) async {
    final cacheDateRaffles =
        CacheController<DateTime>(cacheBoxEnum: CacheBox.DateRaffles);

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
        if (date.weekday == 3) {
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
    } catch (e) {
      print('ERROR!!');
      print(e);
    }
    await cacheDateRaffles.writeByKey(1, secondWendnesday);
    await cacheDateRaffles.writeByKey(2, fourthWendnesday);
  }

  @override
  Future<void> cacheNextRaffleDates(DateTime date) async {
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
  Future<bool> cacheRaffle(TicketRaffle raffle) async {
    final cacheRaffles =
        CacheController<TicketRaffle>(cacheBoxEnum: CacheBox.Raffle);

    return await cacheRaffles.write(raffle) != null;
  }

  @override
  Future<TicketRaffle> sortNumber(TicketRaffle raffle) {
    // TODO: implement sortNumber
    throw UnimplementedError();
  }
}
