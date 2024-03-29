import 'package:troco_premiado/app/modules/home/controllers/history_controller.dart';
import 'package:troco_premiado/app/modules/home/pages/history_page.dart';
import 'package:troco_premiado/app/modules/home/pages/create_ticket_page.dart';
import 'package:troco_premiado/app/modules/home/pages/pending_ticket_page.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => HistoryController(), lazy: true),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => HomePage(args.data)),
        ModularRouter('/addTicket',
            child: (_, args) => CreateTicketPage(createPending: args.data)),
        ModularRouter('/pending', child: (_, args) => PendingTicketPage()),
        ModularRouter('/history', child: (_, args) => HistoryPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
