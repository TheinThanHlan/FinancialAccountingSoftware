import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';
import 'package:flutter/material.dart';
import './GeneralJournalListController.dart';
import 'package:winter/winter.dart';

class GeneralJournalList extends StatelessWidget {
  late final GeneralJournalListController c;
  GeneralJournalList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getIt<GlobalStyle>().topBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              Text(
                c.languageFactory.getLang(0),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                width: 244,
                child: ListTile(
                  leading: Icon(Icons.edit_calendar),
                  title: ValueListenableBuilder(
                    valueListenable: c.targetDate,
                    builder: (context, value, child) =>
                        Text("${value.day}/${value.month}/${value.year}"),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: c.targetDate.value,
                      firstDate: DateTime(0),
                      lastDate: DateTime(2100),
                    ).then((a) {
                      c.targetDate.value = a ?? DateTime.now();
                    });
                  },
                ),
              ),
              ElevatedButton(
                child: Text("Add journal"),
                onPressed: () {
                  c.data!.openAddJournal();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: c.targetDate,
            builder: (context, value, child) => FutureBuilder(
              future: getIt<GeneralJournalDao>().filterWithDate(value),
              builder: (context, snapshot) => SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Time")),
                      DataColumn(label: Text("Description")),
                      DataColumn(label: Container()),
                    ],
                    rows: [
                      if (snapshot.data != null)
                        ...snapshot.data!.map(
                          (a) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  "${a.journalDate.hour}:${a.journalDate.minute}:${a.journalDate.second}",
                                ),
                              ),
                              DataCell(Text(a.description)),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Details"),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
