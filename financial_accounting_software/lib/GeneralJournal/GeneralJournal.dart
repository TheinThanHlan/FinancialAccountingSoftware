import 'package:flutter/material.dart';
import './GeneralJournalController.dart';

class GeneralJournal extends StatelessWidget {
  late final GeneralJournalController c;
  GeneralJournal();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: c.currentPage,
      builder: (context, value, child) {
        return value;
      },
    );
  }
}
