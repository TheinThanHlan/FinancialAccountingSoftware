import 'package:financial_accounting_software/GeneralJournal/AddJournal/all.dart';
import 'package:financial_accounting_software/GeneralJournal/GeneralJournalList/all.dart';
import 'package:financial_accounting_software/JournalDetails/JournalDetailsModel.dart';
import 'package:financial_accounting_software/JournalDetails/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GeneralJournalModel.dart';
import 'GeneralJournal.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class GeneralJournalController {
  late final GeneralJournalModel? data;
  late final GeneralJournal view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);
  late final ValueNotifier<Widget> currentPage;
  //I created the instant in class level to journal list as singleton in this scope.
  late final GeneralJournalListController journalList;
  GeneralJournalController(this.view, this.languageFactory, {this.data}) {
    view.c = this;
    journalList = getIt<GeneralJournalListController>(
      param1: GeneralJournalListModel(
        openAddJournal: openAddJournal,
        openJournalDetails: openJournalDetails,
      ),
    );
    currentPage = ValueNotifier(journalList.getView());
    //currentPage = ValueNotifier(Container());
  }
  String greet = "Hello from GeneralJournalPage";
  void reset() {}
  void openAddJournal() {
    currentPage.value = getIt<AddJournalController>(
      param1: AddJournalModel(closeAddJournal: comeBackToMainPage),
    ).getView();
  }

  void comeBackToMainPage() {
    currentPage.value = journalList.getView();
  }

  void openJournalDetails(BuildContext context, int journalId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => getIt<JournalDetailsController>(
          param1: JournalDetailsModel(journalId: journalId),
        ).getView(),
      ),
    );
  }
}
