import 'package:flutter/foundation.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

abstract class IRaffle {
  Future<TicketRaffle> sortNumber();
  Future<void> cacheNewRaffleDates({@required int month, @required int year});
}
