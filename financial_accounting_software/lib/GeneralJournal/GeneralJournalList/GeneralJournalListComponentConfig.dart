import 'GeneralJournalListController.dart';
import 'GeneralJournalList.dart';
import 'GeneralJournalListModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class GeneralJournalListComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerFactoryParam<
      GeneralJournalListController,
      GeneralJournalListModel,
      Null
    >(
      instanceName: instanceName,
      (p1, p2) => GeneralJournalListController(
        GeneralJournalList(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
        data: p1,
      ),
    );
    debugPrint("\t~>\tGeneralJournalList injected;");
  }
}
