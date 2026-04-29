import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/dao/JournalEntryDao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/cupertino.dart';

import 'ChartOfAccountModel.dart';
import 'ChartOfAccount.dart';
import 'package:winter/winter.dart';

class ChartOfAccountController implements WinterController {
  final ChartOfAccountModel _model;
  late final ChartOfAccount _view;
  final WinterLanguageFactory _lf;
  final COADao userDao = getIt<COADao>();
  late final Future<void> Function(BuildContext, String) alertUserMessage;

  //final module = getIt<GetIt>(instanceName:);
  ChartOfAccountController(this._lf, this._model) {
    _view = ChartOfAccount(_lf, _model, getCoaData, setSearchValue);
    _view.deleteAccount = deleteAccount;
    alertUserMessage = _view.alertUserMessage;
  }
  void reset() {}

  WinterView getView() {
    return this._view;
  }

  Future<List<COA>> getCoaData(String accountNameOrCode) async {
    return userDao.search(accountNameOrCode);
  }

  Future<void> deleteAccount(int id, BuildContext context) async {
    bool isExist = await getIt<JournalEntryDao>().checkIfCoaUsed(id);
    if (isExist) {
      alertUserMessage(
        context,
        "Cannot delete account: It is currently being used in a journal entry transaction.",
      );
    } else {
      await getIt<COADao>().delete(id);
      _view.tableStateSetter!(() {});
    }
  }

  void setSearchValue(String? searchValue) {
    _model.searchValue = searchValue ?? "";
    _view.tableStateSetter!(() {});
  }
}
