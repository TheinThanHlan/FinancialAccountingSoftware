import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:financial_accounting_software/data/model/JournalEntry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import './AddJournalController.dart';
import 'package:winter/winter.dart';

class AddJournal extends StatelessWidget {
  late final AddJournalController c;
  AddJournal();
  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return Form(
      key: c.journalSaveFormKey,
      child: Column(
        children: [
          //topbar
          Container(
            height: getIt<GlobalStyle>().topBarHeight,
            child: Row(
              spacing: 8,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    c.data!.closeAddJournal();
                  },
                ),
                Text(
                  "Journal entry",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Expanded(child: Container()),
                ValueListenableBuilder(
                  valueListenable: c.entries,
                  builder: (context, value, child) {
                    c.generalJournal.entries = value;
                    return c.generalJournal.isBalanced()
                        ? Text(
                            "Balanced",
                            style: getIt<GlobalStyle>()
                                .successLabel(context)
                                .copyWith(fontSize: 21),
                          )
                        : Text(
                            "Unbalance",
                            style: getIt<GlobalStyle>()
                                .dangerLabel(context)
                                .copyWith(fontSize: 21),
                          );
                  },
                ),
                ElevatedButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (!c.journalSaveFormKey.currentState!.validate()) {
                    } else if (c.generalJournal.entries.length == 0) {
                      showSaveErrorDialog(
                        context,
                        "Please add journal entries.",
                      );
                    } else if (!c.generalJournal.isBalanced()) {
                      showSaveErrorDialog(
                        context,
                        "Your journal entry is not balance.",
                      );
                    } else {
                      getIt<GeneralJournalDao>().insert(c.generalJournal);
                      c.data!.closeAddJournal();
                    }
                  },
                ),
              ],
            ),
          ),
          //mid layout
          Container(
            height: getIt<GlobalStyle>().topBarHeight * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 377,
                  child: ListTile(
                    leading: Text(
                      "Transaction Date : ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    title: Text(
                      "1/1/2004",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit_calendar_outlined),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 377,
                  child: TextFormField(
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: "Journal entry description.",
                    ),
                    onChanged: (a) {
                      c.generalJournal.description = a;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the journal entry description";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 144,
                  child: ElevatedButton(
                    child: Text("Add row"),
                    onPressed: () {
                      showAddRowDialog(context).then((a) async {
                        await Future.delayed(Duration(seconds: 1)).then((x) {
                          c.resetAddDialogData();
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //entry table
          Flexible(
            child: SizedBox(
              width: double.maxFinite,
              child: ValueListenableBuilder(
                valueListenable: c.entries,
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Particulars")),
                        DataColumn(label: Text("Debit")),
                        DataColumn(label: Text("Credit")),
                        DataColumn(label: Text("")),
                      ],
                      rows: value.map((a) {
                        return DataRow(
                          cells: [
                            DataCell(Text(a.affectedAccount.account)),
                            DataCell(
                              Text(a.isDebit ? a.amount.toString() : "0"),
                            ),
                            DataCell(
                              Text(!a.isDebit ? a.amount.toString() : "0"),
                            ),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  c.entries.value.remove(a);
                                  c.entries.value = [...c.entries.value];
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //this dialog is to show the error meassege at the time of saving
  Future<void> showSaveErrorDialog(BuildContext context, String errrMessage) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            errrMessage,
            style: getIt<GlobalStyle>()
                .dangerLabel(context)
                .copyWith(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(this);
              },
            ),
          ],
        );
      },
    );
  }

  //add row dialog
  Future<void> showAddRowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: c.currentAddDialogState,
          builder: (context, value, child) {
            switch (value) {
              case 0:
                return AlertDialog(
                  title: Text("Select Account"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Search with id (or) name",
                        ),
                        onChanged: (val) {
                          getIt<COADao>().search(val).then((a) {
                            c.chart_of_account_notifier.value = a;
                          });
                        },
                      ),
                      SizedBox(
                        width: 610,
                        height: 377,
                        child: ValueListenableBuilder(
                          valueListenable: c.chart_of_account_notifier,
                          builder: (context, value, child) {
                            return SingleChildScrollView(
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text("Code"),
                                    numeric: true,
                                  ),
                                  DataColumn(label: Text("Account name")),
                                  DataColumn(label: Text("")),
                                ],
                                rows: value
                                    .map(
                                      (e) => DataRow(
                                        cells: [
                                          DataCell(Text(e.code.toString())),
                                          DataCell(Text(e.account.toString())),
                                          DataCell(
                                            IconButton(
                                              icon: Icon(Icons.arrow_right),
                                              onPressed: () {
                                                c.addEntry = JournalEntry(
                                                  0,
                                                  e,
                                                  true,
                                                  0,
                                                );
                                                c.currentAddDialogState.value =
                                                    1;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(this);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              case 1:
                return AlertDialog(
                  title: Text(c.addEntry!.affectedAccount.account),
                  content: SizedBox(
                    width: 610,
                    height: 200,
                    child: Column(
                      spacing: 13,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: c.addJournalErrorNotifier,
                          builder: (context, value, child) {
                            return Text(
                              value,
                              style: getIt<GlobalStyle>().dangerLabel(context),
                            );
                          },
                        ),

                        StatefulBuilder(
                          builder: (context, stateSetter) {
                            return Row(
                              children: [
                                Text("Transaction Type : "),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: const Text("Debit"),
                                    leading: Radio<bool>(
                                      value: true,
                                      groupValue: c.addEntry!.isDebit,
                                      onChanged: (bool? value) {
                                        stateSetter(() {
                                          c.addEntry!.isDebit = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: const Text("Credit"),
                                    leading: Radio<bool>(
                                      value: false,
                                      groupValue: c.addEntry!.isDebit,
                                      onChanged: (bool? value) {
                                        stateSetter(() {
                                          c.addEntry!.isDebit = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Amount",
                              hintText:
                                  "Assets need a ${c.generalJournal.findBalanceValue()} adjustment to balance",
                            ),
                            onChanged: (String a) {
                              c.addEntry!.amount = double.tryParse(a) ?? 0;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(this);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (c.addEntry!.amount != 0) {
                          Navigator.of(context).pop(this);
                          c.entries.value = [...c.entries.value, c.addEntry!];
                        } else {
                          c.addJournalErrorNotifier.value =
                              "Please fill the amount";
                        }
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
