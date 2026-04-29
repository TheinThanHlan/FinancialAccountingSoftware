import 'package:financial_accounting_software/JournalDetails/all.dart';
import 'package:financial_accounting_software/data/dao/GeneralLedgerDao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/material.dart';
import 'package:winter/components/TableWithStickyHeader/all.dart';
import './GeneralLedgerController.dart';
import 'package:winter/winter.dart';

class GeneralLedger extends StatelessWidget {
  late final GeneralLedgerController c;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: c.getCOAHierarchy(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Row(
            mainAxisSize: .max,
            children: [
              Container(
                width: 425,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StatefulBuilder(
                    builder: (context, setState) => Column(
                      spacing: 10,
                      crossAxisAlignment: .stretch,
                      children: [
                        Text(
                          "Ledger Level",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: .start,
                        ),
                        Wrap(
                          direction: .horizontal,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (
                              int a = 0;
                              a < snapshot.data!.hierarchy.length;
                              a++
                            )
                              InkWell(
                                borderRadius: .circular(4),
                                onTap: () {
                                  c.selectedCoaHierarchy = a;
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: .center,
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(4),
                                    border: BoxBorder.all(
                                      color: Colors.black26,
                                    ),
                                    color: c.selectedCoaHierarchy == a
                                        ? Colors.black12
                                        : Colors.transparent,
                                  ),
                                  width: 50,
                                  height: 40,
                                  child: Text(
                                    (a + 1).toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Container(
                          alignment: .topLeft,
                          width: 500,
                          child: TextFormField(
                            onChanged: (a) {
                              c.searchCoa = a;
                              setState(() {});
                            },
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Search",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        //title of below list
                        Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text("Account Code.", textAlign: .center),
                            ),
                            Expanded(child: Text("Name", textAlign: .center)),
                          ],
                        ),
                        //table
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: .stretch,
                              mainAxisAlignment: .start,
                              children: [
                                for (var a
                                    in snapshot.data!.hierarchy[c
                                        .selectedCoaHierarchy])
                                  if (a.account.toLowerCase().contains(
                                        c.searchCoa.toLowerCase(),
                                      ) ||
                                      a.code.contains(c.searchCoa) ||
                                      c.searchCoa.isEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: .circular(10),
                                        color:
                                            a.code ==
                                                c
                                                    .currentSelectedCOANotifier
                                                    .value
                                                    .code
                                            ? Colors.black12
                                            : Colors.transparent,
                                      ),
                                      height: 100,
                                      child: InkWell(
                                        borderRadius: .circular(10),
                                        onTap: () {
                                          c.currentSelectedCOANotifier.value =
                                              a;
                                          setState(() {});
                                        },
                                        child: Row(
                                          spacing: 21,
                                          crossAxisAlignment: .center,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                a.code,
                                                textAlign: .center,
                                                softWrap: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.account,
                                                textAlign: .start,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: c.currentSelectedCOANotifier,
                  builder: (context, _, _) {
                    if (c.currentSelectedCOANotifier.value != COA.empty()) {
                      return ValueListenableBuilder(
                        valueListenable: c.startingDateNotifier,
                        builder: (context, _, _) {
                          return Column(
                            spacing: 13,
                            children: [
                              //starting date button
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Starting date : ${c.startingDateNotifier.value.day}/${c.startingDateNotifier.value.month}/${c.startingDateNotifier.value.year} ",
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        c.startingDateNotifier.value =
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(0),
                                              lastDate: DateTime.now(),
                                            ) ??
                                            DateTime(2000);
                                      },
                                      child: Text("select"),
                                    ),
                                  ],
                                ),
                              ),

                              //Table
                              Expanded(
                                child: ValueListenableBuilder(
                                  valueListenable: c.currentSelectedCOANotifier,
                                  builder: (context, _, _) => FutureBuilder(
                                    future: getIt<GeneralLedgerDao>()
                                        .getGeneralLedgerOf(
                                          c.currentSelectedCOANotifier.value,
                                        ),
                                    builder: (context, snapshot) {
                                      double balance = 0;
                                      if (snapshot.data == null) {
                                        return Container();
                                      }

                                      return getIt<TableWithStickyHeaderController>(
                                        param1: TableWithStickyHeaderModel(
                                          tableCellPadding: .symmetric(
                                            horizontal: 13,
                                            vertical: 21,
                                          ),
                                          [
                                            TableColumn1("Date"),
                                            TableColumn1("Time"),
                                            TableColumn1("Description"),
                                            TableColumn1(
                                              "Debit",
                                              isNumberic: true,
                                            ),
                                            TableColumn1(
                                              "Credit",
                                              isNumberic: true,
                                            ),
                                            TableColumn1(
                                              "Balance",
                                              isNumberic: true,
                                            ),
                                            TableColumn1("Details"),
                                          ],

                                          [
                                            ...snapshot.data!
                                                .filterTheGeneralJournalsFromSpecifyDate(
                                                  c.startingDateNotifier.value,
                                                )
                                                .map((a) {
                                                  balance += a.entries[0]
                                                      .getConditionedAmount();
                                                  return TableRow1([
                                                    TableCell1(
                                                      Text(
                                                        a.id != 0
                                                            ? """${a.journalDate.day}/${a.journalDate.month}/${a.journalDate.year}"""
                                                            : "",
                                                      ),
                                                    ),
                                                    TableCell1(
                                                      Text(
                                                        a.id != 0
                                                            ? """${a.journalDate.hour}:${a.journalDate.minute}"""
                                                            : "",
                                                      ),
                                                    ),
                                                    TableCell1(
                                                      Text(
                                                        a.description,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                    TableCell1(
                                                      Text(
                                                        a.entries[0].isDebit
                                                            ? a
                                                                  .entries[0]
                                                                  .amount
                                                                  .toString()
                                                            : "-",
                                                      ),
                                                    ),
                                                    TableCell1(
                                                      Text(
                                                        !a.entries[0].isDebit
                                                            ? a
                                                                  .entries[0]
                                                                  .amount
                                                                  .toString()
                                                            : "-",
                                                      ),
                                                    ),
                                                    TableCell1(
                                                      Text(balance.toString()),
                                                    ),
                                                    TableCell1(
                                                      a.id != 0
                                                          ? OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                  context,
                                                                ).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        getIt<
                                                                              JournalDetailsController
                                                                            >(
                                                                              param1: JournalDetailsModel(
                                                                                journalId: a.id,
                                                                              ),
                                                                            )
                                                                            .getView(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                "Details",
                                                              ),
                                                            )
                                                          : Container(),
                                                    ),
                                                  ]);
                                                }),
                                          ],
                                        ),
                                      ).getView();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
