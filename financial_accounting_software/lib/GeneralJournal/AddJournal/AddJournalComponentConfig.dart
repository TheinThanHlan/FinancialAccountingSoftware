import 'AddJournalController.dart';
import 'AddJournal.dart';
import 'AddJournalModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class AddJournalComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerFactoryParam<AddJournalController, AddJournalModel, Null>(
      instanceName: instanceName,
      (p1, p2) => AddJournalController(
        AddJournal(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
        data: p1,
      ),
    );
    debugPrint("\t~>\tAddJournal injected;");
  }
}
