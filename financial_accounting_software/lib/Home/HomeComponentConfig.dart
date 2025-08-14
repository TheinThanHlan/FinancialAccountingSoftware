import 'package:financial_accounting_software/GeneralJournal/all.dart';
import 'package:flutter/cupertino.dart';

import 'HomeController.dart';
import 'Home.dart';
import 'HomeModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class HomeComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerSingleton(
      instanceName: instanceName,
      HomeController(
        Home(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
      ),
    );
    debugPrint("\t~>\tHome injected;");
  }
}
