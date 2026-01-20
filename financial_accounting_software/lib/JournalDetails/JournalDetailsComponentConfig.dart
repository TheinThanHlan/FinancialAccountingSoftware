import 'JournalDetailsController.dart';
import 'JournalDetails.dart';
import 'JournalDetailsModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class JournalDetailsComponentConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    getIt.registerFactoryParam<
      JournalDetailsController,
      JournalDetailsModel,
      void
    >(
      instanceName: instanceName,
      (p1, p2) => JournalDetailsController(
        JournalDetails(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
        data: p1,
      ),
    );
    debugPrint("\t~>\tJournalDetails injected;");
  }
}
