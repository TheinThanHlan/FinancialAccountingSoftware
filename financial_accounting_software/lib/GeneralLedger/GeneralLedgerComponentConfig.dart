import 'GeneralLedgerController.dart';
import 'GeneralLedger.dart';
import 'GeneralLedgerModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class GeneralLedgerComponentConfig implements Configurer{
 Future<void> config({String?instanceName})async{
  getIt.registerSingleton(instanceName:instanceName,GeneralLedgerController(

    GeneralLedger(), LanguageFactory(
    getIt<ValueNotifier<String>>(instanceName: "currentLanguage"))));
   debugPrint("\t~>\tGeneralLedger injected;");
 }

}
