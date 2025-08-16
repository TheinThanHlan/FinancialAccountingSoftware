import 'GeneralJournalListModel.dart';
import 'GeneralJournalList.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'package:flutter/widgets.dart';

class GeneralJournalListController implements WinterController {
  late final GeneralJournalListModel? data;
  late final GeneralJournalList view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);
  final ValueNotifier<DateTime> targetDate = ValueNotifier(
    DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
  );
  GeneralJournalListController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
  }
  String greet = "Hello from GeneralJournalListPage";
  void reset() {}

  Widget getView() {
    return this.view;
  }
}
