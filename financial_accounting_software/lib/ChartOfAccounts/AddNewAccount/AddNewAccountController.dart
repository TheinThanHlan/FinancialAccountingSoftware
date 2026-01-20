import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:financial_accounting_software/data/model/COA.dart';

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

  //final module = getIt<GetIt>(instanceName:);
  AddNewAccountController(this.view, this.languageFactory, {this.data}) {
    view.c = this;
  }
  String greet = "Hello from AddNewAccountPage";
  void reset() {}

  @override
  Widget getView() {
    return view;
  }

  Future<bool> createNewAccount() async {
    try {
      await getIt<COADao>().add(COA(0, code, account, accountType.value));
      return true;
    } on DatabaseException catch (e) {
      return false;
    }
  }
}
