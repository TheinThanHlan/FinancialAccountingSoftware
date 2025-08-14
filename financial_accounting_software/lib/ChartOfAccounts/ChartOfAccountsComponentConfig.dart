import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/all.dart';
import 'package:financial_accounting_software/ChartOfAccounts/COAList/all.dart';

import 'ChartOfAccountsController.dart';
import 'ChartOfAccounts.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

import 'languages/LanguageFactory.dart';

class ChartOfAccountsComponentConfig implements Configurer {
  Future<void> config({String? instanceName}) async {
    COAListComponentConfig().config();
    AddNewAccountComponentConfig().config();
    getIt.registerSingleton(
      instanceName: instanceName,
      ChartOfAccountsController(
        ChartOfAccounts(),
        LanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
        ),
      ),
    );
    debugPrint("\t~>\tChartOfAccounts injected;");
  }
}
