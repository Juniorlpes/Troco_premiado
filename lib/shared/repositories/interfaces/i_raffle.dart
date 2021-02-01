import 'package:flutter/foundation.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

abstract class IRaffle {
  Future<TicketRaffle> sortNumber(Account mainAccount);
  Future<bool> cacheRaffle(TicketRaffle raffle);
  Future<void> cacheRaffleDates({@required int month, @required int year});
  Future<void> cacheNextRaffleDates(DateTime date);
}
