import 'package:troco_premiado/app/modules/home/pages/raffle_page.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => HomePage(args.data)),
        ModularRouter('/addTicket', child: (_, args) => CreateRafflePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
