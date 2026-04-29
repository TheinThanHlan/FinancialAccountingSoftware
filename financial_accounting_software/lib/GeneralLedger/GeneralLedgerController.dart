import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/AccountType.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:financial_accounting_software/data/model/COAHierarchy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'GeneralLedgerModel.dart';
import 'GeneralLedger.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class GeneralLedgerController {
  late final GeneralLedgerModel? data;
  late final GeneralLedger view;
  late final LanguageFactory languageFactory;

  //use to notivy the current coa to coa detailed side
  ValueNotifier<COA> currentSelectedCOANotifier = ValueNotifier(COA.empty());
  ValueNotifier<DateTime> startingDateNotifier = ValueNotifier(DateTime(0));
  int selectedCoaHierarchy = 0;
  String searchCoa = "";

  ValueNotifier<DateTimeRange> currentDateTimeRange = ValueNotifier(
    DateTimeRange(start: DateTime.utc(0), end: DateTime.now()),
  );

  //final module = getIt<GetIt>(instanceName:);
  GeneralLedgerController(this.view, this.languageFactory, {this.data}) {
    view.c = this;
    view.getCoas = getCoas;
  }
  void reset() {}
  Future<List<COA>> getCoas(String n) async {
    return getIt<COADao>().search(n);
  }
}
