import 'package:file_picker/file_picker.dart';
import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/AddNewAccountController.dart';
import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/all.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/material.dart';

import 'COAListModel.dart';
import 'COAList.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'dart:io' as io;

class COAListController implements WinterController {
  late final COAListModel? data;
  late final COAList view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);

  COAListController(this.view, this.languageFactory, {this.data}) {
    view.c = this;
  }
  String greet = "Hello from COAListPage";
  void reset() {}

  @override
  Widget getView() {
    return view;
  }

  void exportCOAList() {
    FilePicker.platform
        .getDirectoryPath(dialogTitle: "Choose the export location.")
        .then((String? a) {
          if (a != null && a.isNotEmpty) {
            int countA = 0;
            while (true) {
              countA++;
              String fname = "$a/ChartOfAccounts-$countA.csv";
              if (!io.File(fname).existsSync()) {
                getIt<COADao>().getAll().then((coaList) {
                  String writeStringA = "code,account,isIncreaseInDebit";
                  coaList.forEach((coa) {
                    writeStringA += "\n${coa.code},${coa.account}";
                  });
                  io.File(fname).writeAsStringSync(writeStringA);
                });
                break;
              }
            }
          }
        });
  }
}
