import 'package:financial_accounting_software/GeneralJournal/AddJournal/AddJournalComponentConfig.dart';
import 'package:financial_accounting_software/GeneralJournal/GeneralJournalList/GeneralJournalListComponentConfig.dart';

import 'GeneralJournalController.dart';
import 'GeneralJournal.dart';
import 'GeneralJournalModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class GeneralJournalComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    GeneralJournalListComponentConfig().config();
    AddJournalComponentConfig().config();
    getIt.registerSingleton(
      instanceName: instanceName,
      GeneralJournalController(
        GeneralJournal(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
      ),
    );
    debugPrint("\t~>\tGeneralJournal injected;");
  }
}
