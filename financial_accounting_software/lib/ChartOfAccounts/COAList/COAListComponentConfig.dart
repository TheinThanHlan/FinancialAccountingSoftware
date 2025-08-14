import 'COAListController.dart';
import 'COAList.dart';
import 'COAListModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class COAListComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerFactoryParam<COAListController, COAListModel, Null>(
      instanceName: instanceName,
      (p1, p2) {
        return COAListController(
          COAList(),
          LanguageFactory(
            getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
          ),
          data: p1,
        );
      },
    );
    debugPrint("\t~>\tCOAList injected;");
  }
}
