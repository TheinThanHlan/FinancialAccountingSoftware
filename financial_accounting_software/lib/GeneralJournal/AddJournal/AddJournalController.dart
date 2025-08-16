import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/dao/JournalEntryDao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:financial_accounting_software/data/model/GeneralJournal.dart';
import 'package:financial_accounting_software/data/model/JournalEntry.dart';
import 'package:flutter/material.dart';

import 'AddJournalModel.dart';
import 'AddJournal.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'package:flutter/widgets.dart';

class AddJournalController implements WinterController {
  late final AddJournalModel? data;
  late final AddJournal view;
  late final LanguageFactory languageFactory;
  late final GeneralJournal generalJournal;
  //form keys
  final journalSaveFormKey = GlobalKey<FormState>();

  //list of journal entry
  final ValueNotifier<List<JournalEntry>> entries = ValueNotifier([]);
  final ValueNotifier<bool> journalEntryDateTimeChangeNotifier = ValueNotifier(
    false,
  );
  late final ValueNotifier<List<COA>> chart_of_account_notifier;
  final ValueNotifier<DateTime> createdDate = ValueNotifier(DateTime.now());
  //variables use in dilog
  late final ValueNotifier<int> currentAddDialogState = ValueNotifier(0);
  JournalEntry? addEntry;
  ValueNotifier<String> addJournalErrorNotifier = ValueNotifier("");
  //final module = getIt<GetIt>(instanceName:);
  AddJournalController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
    this.generalJournal = GeneralJournal(
      0,
      "",
      createdDate.value,
      entries.value,
    );
    getIt<COADao>().getAll().then((a) {
      chart_of_account_notifier = ValueNotifier(a);
    });
  }

  String greet = "Hello from AddJournalPage";

  resetAddDialogData() async {
    getIt<COADao>().getAll().then((a) {
      chart_of_account_notifier.value = a;
    });
    currentAddDialogState.value = 0;
    addEntry = null;
    addJournalErrorNotifier.value = "";
  }

  void reset() {}

  Widget getView() {
    return this.view;
  }
}
