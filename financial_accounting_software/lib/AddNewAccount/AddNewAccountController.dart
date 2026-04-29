import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/material.dart';

import 'AddNewAccountModel.dart';
import 'AddNewAccount.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'package:flutter/widgets.dart';

class AddNewAccountController implements WinterController {
  late final AddNewAccountModel? data;
  late final AddNewAccount view;
  late final LanguageFactory languageFactory;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ValueNotifier<AccountType> accountType;
  String account = "";
  String code = "";
  ValueNotifier<(String, Color)> message = ValueNotifier((
    "",
    Colors.transparent,
  ));

  //final module = getIt<GetIt>(instanceName:);
  AddNewAccountController(this.view, this.languageFactory, {this.data}) {
    view.c = this;
  }
  String greet = "Hello from AddNewAccountPage";
  void reset() {}

  @override
  WinterView getView() {
    return view;
  }

  Future<bool> createNewAccount() async {
    try {
      if (int.parse(code[0]) == accountType.value.start_with) {
        await getIt<COADao>().add(COA(0, code, account, accountType.value));
        message.value = ("Account creation success.", Colors.lightGreen);

        data!.tableStateSetter!(() {});
        return true;
      } else {
        message.value = (
          "Account code for ${accountType.value.name} account should start with ${accountType.value.start_with}",
          Colors.red,
        );
        return false;
      }
    } on DatabaseException catch (e) {
      message.value = ("Duplicate account.", Colors.red);
      return false;
    }
  }
}
