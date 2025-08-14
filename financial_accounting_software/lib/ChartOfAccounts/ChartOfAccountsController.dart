import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/all.dart';
import 'package:financial_accounting_software/ChartOfAccounts/COAList/COAList.dart';
import 'package:financial_accounting_software/ChartOfAccounts/COAList/COAListController.dart';
import 'package:financial_accounting_software/ChartOfAccounts/COAList/COAListModel.dart';
import 'package:flutter/cupertino.dart';

import 'ChartOfAccountsModel.dart';
import 'ChartOfAccounts.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class ChartOfAccountsController {
  late final ChartOfAccountsModel? data;
  late final ChartOfAccounts view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);
  //late final ValueNotifier<String> currentPage;

  late ValueNotifier<Widget> currentPage;
  ChartOfAccountsController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
    currentPage = ValueNotifier(
      getIt<COAListController>(
        param1: COAListModel(openAddNewAccountWindow),
      ).getView(),
    );
  }
  String greet = "Hello from ChartOfAccountsPage";

  void completeAddNewAccount() {
    currentPage.value = getIt<COAListController>(
      param1: COAListModel(openAddNewAccountWindow),
    ).getView();
  }

  void openAddNewAccountWindow() {
    if (currentPage.value is COAList) {
      currentPage.value = getIt<AddNewAccountController>(
        param1: AddNewAccountModel(completeAddNewAccount),
      ).getView();
    }
  }

  void reset() {}
}
