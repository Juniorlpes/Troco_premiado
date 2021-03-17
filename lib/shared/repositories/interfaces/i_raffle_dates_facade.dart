abstract class IRaffleDateFacade {
  Future<void> cacheRaffleDates({int month, int year});
  Future<void> cacheBigLuckyWendnesday({int month, int year});
  Future<void> cacheNextRafflesDates(DateTime date);
  Future<DateTime> getNextRaffleDate();
  Future<DateTime> getBigLuckyRaffleDate();
}
