import 'package:financial_accounting_software/ChartOfAccounts/all.dart';
import 'package:financial_accounting_software/GeneralJournal/GeneralJournalController.dart';
import 'package:financial_accounting_software/GeneralLedger/all.dart';
import 'package:financial_accounting_software/Home/ui_models/SupportedLanguage.dart';
import 'package:flutter/widgets.dart';

import 'HomeModel.dart';
import 'Home.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class HomeController {
  late final HomeModel? data;
  late final Home view;
  late final LanguageFactory languageFactory;
  late final ValueNotifier<String> currentPage;
  final Map<String, Widget> pages = {
    "General Journal": getIt<GeneralJournalController>().view,
    "General Ledger": getIt<GeneralLedgerController>().view,
    "Chart Of Accounts": getIt<ChartOfAccountsController>().view,
  };
  List<SupportedLanguage> supportedLanguages = [
    SupportedLanguage("mm", "Myanmar"),
    SupportedLanguage("en", "English"),
  ];
  //final module = getIt<GetIt>(instanceName:);
  HomeController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
    this.currentPage = ValueNotifier(pages.keys.first);
  }

  String greet = "Hello from HomePage";
  void reset() {}
}
