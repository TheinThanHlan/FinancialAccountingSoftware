import 'package:financial_accounting_software/AddNewAccount/AddNewAccountController.dart';
import 'package:financial_accounting_software/AddNewAccount/AddNewAccountModel.dart';
import 'package:financial_accounting_software/ChartOfAccount/ChartOfAccountController.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:winter/components/TableWithStickyHeader/all.dart';
import 'package:winter/winter.dart';
import "ChartOfAccountModel.dart";

class ChartOfAccount extends StatelessWidget implements WinterView {
  //late final ChartOfAccountController c;
  final WinterLanguageFactory _lf;
  final ChartOfAccountModel _model;
  final Future<List<COA>> Function(String) getCoaData;
  final void Function(String?) setSearchValue;
  late final Future<void> Function(int, BuildContext) deleteAccount;
  void Function(void Function())? tableStateSetter;
  ChartOfAccount(this._lf, this._model, this.getCoaData, this.setSearchValue);
  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return Column(
      spacing: 13,
      children: [
        SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(
                width: 377,
                height: double.maxFinite,
                child: TextFormField(
                  onChanged: setSearchValue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),

                    label: Text("Search with account name (or) code"),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => getIt<AddNewAccountController>(
                      param1: AddNewAccountModel(tableStateSetter),
                    ).getView(),
                  );
                },
                child: Text("Add Account"),
              ),
            ],
          ),
        ),
        Expanded(
          child: StatefulBuilder(
            builder: (context, setState) {
              this.tableStateSetter = setState;
              return FutureBuilder(
                future: getCoaData(_model.searchValue),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return getIt<TableWithStickyHeaderController>(
                      param1: TableWithStickyHeaderModel(
                        [
                          TableColumn1(
                            "Code",
                            tableColumnWidth: FlexColumnWidth(0.3),
                          ),
                          TableColumn1(
                            "Name",
                            tableColumnWidth: FlexColumnWidth(0.5),
                          ),
                          TableColumn1(
                            "Account type",
                            tableColumnWidth: FlexColumnWidth(0.3),
                          ),
                          TableColumn1(
                            "",
                            tableColumnWidth: FixedColumnWidth(95),
                          ),
                        ],
                        [
                          ...(snapshot.data ?? []).map(
                            (a) => TableRow1([
                              TableCell1(Text(a.code)),
                              TableCell1(Text(a.account)),
                              TableCell1(Text(a.accountType.name)),
                              TableCell1(
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deleteAccount(a.id, context);
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ],
                        tableCellPadding: EdgeInsets.symmetric(
                          vertical: 21,
                          horizontal: 10,
                        ),
                      ),
                    ).getView();
                  }
                  return Container();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> alertUserMessage(BuildContext context, String msg) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(msg),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("close"),
            ),
          ],
        );
      },
    );
  }
}
