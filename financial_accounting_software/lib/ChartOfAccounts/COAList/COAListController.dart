import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/AddNewAccountController.dart';
import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/all.dart';
import 'package:flutter/material.dart';

import 'COAListModel.dart';
import 'COAList.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class COAListController implements WinterController {
  late final COAListModel? data;
  late final COAList view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);

  COAListController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
  }
  String greet = "Hello from COAListPage";
  void reset() {}

  Widget getView() {
    return this.view;
  }
}
