import 'package:winter/winter.dart';

class GeneralJournalListModel implements WinterModel {
  final void Function() openAddJournal;
  GeneralJournalListModel({required this.openAddJournal});
}
