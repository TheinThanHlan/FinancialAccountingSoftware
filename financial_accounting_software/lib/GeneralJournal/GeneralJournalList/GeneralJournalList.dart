import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';
import 'package:flutter/material.dart';
import 'package:winter/components/TableWithStickyHeader/TableWithStickyHeaderController.dart';
import 'package:winter/components/TableWithStickyHeader/TableWithStickyHeaderModel.dart';
import './GeneralJournalListController.dart';
import 'package:winter/winter.dart';

class GeneralJournalList extends StatelessWidget implements WinterView {
  late final GeneralJournalListController c;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getIt<GlobalStyle>().topBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              Text(
                c.languageFactory.getLang(0),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
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
                      lastDate: DateTime.now(),
                    ).then((a) {
                      c.targetDate.value =
                          a ??
                          DateTime.now().copyWith(
                            hour: 0,
                            minute: 0,
                            second: 0,
                          );
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
              builder: (context, snapshot) =>
                  getIt<TableWithStickyHeaderController>(
                    param1: TableWithStickyHeaderModel(
                      [
                        TableColumn1("Time"),
                        TableColumn1("Description"),
                        TableColumn1(""),
                      ],
                      [
                        if (snapshot.data != null)
                          ...snapshot.data!.map(
                            (a) => TableRow1([
                              TableCell1(
                                Text(
                                  "${a.journalDate.hour}:${a.journalDate.minute}:${a.journalDate.second}",
                                ),
                              ),
                              TableCell1(Text(a.description)),
                              TableCell1(
                                ElevatedButton(
                                  onPressed: () {
                                    c.data!.openJournalDetails(context, a.id);
                                  },
                                  child: Text("Details"),
                                ),
                              ),
                            ]),
                          ),
                      ],
                    ),
                  ).getView(),
              /*
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
                                  onPressed: () {
                                    c.data!.openJournalDetails(context, a.id);
                                  },
                                  child: Text("Details"),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),*/
            ),
          ),
        ),
      ],
    );
  }
}
