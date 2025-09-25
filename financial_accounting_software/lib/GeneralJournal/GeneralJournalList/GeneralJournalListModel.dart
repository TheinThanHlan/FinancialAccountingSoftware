import 'package:flutter/widgets.dart';
import 'package:winter/winter.dart';

class GeneralJournalListModel implements WinterModel {
  final void Function() openAddJournal;
  final void Function(BuildContext, int) openJournalDetails;
  GeneralJournalListModel({
    required this.openAddJournal,
    required this.openJournalDetails,
  });
}
