import 'AddNewAccountController.dart';
import 'AddNewAccount.dart';
import 'AddNewAccountModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class AddNewAccountComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerFactoryParam<
      AddNewAccountController,
      AddNewAccountModel,
      Null
    >(
      instanceName: instanceName,
      (p1, p2) => AddNewAccountController(
        AddNewAccount(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
        data: p1,
      ),
    );
    debugPrint("\t~>\tAddNewAccount injected;");
  }
}
