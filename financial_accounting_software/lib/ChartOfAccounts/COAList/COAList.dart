import 'package:file_picker/file_picker.dart';
import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:flutter/material.dart';
import './COAListController.dart';
import 'package:winter/winter.dart';

class COAList extends StatelessWidget {
  late final COAListController c;
  COAList({super.key});
  ValueNotifier<int> x = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: getIt<GlobalStyle>().backgroundColor,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chart of accounts",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              //SizedBox(
              //  width: 233,
              //  child: ListTile(
              //    title: Text("Import"),
              //    leading: Icon(Icons.download),
              //    onTap: () {
              //      //print("haha");
              //      //c.data!.openAddNewAccountWindow();

              //      asksUserConfirmationToBackupAndDeleteDataBeforeImportingNewChartOfAccount(
              //        context,
              //      ).then((a) {});
              //    },
              //  ),
              //),
              //SizedBox(
              //  width: 233,
              //  child: ListTile(
              //    title: Text("Export"),
              //    leading: Icon(Icons.upload),
              //    onTap: () {
              //      //print("haha");
              //      c.exportCOAList();
              //    },
              //  ),
              //),
              SizedBox(
                width: 233,
                child: ListTile(
                  title: Text("Add account"),
                  leading: Icon(Icons.add_box),
                  onTap: () {
                    //print("haha");
                    c.data!.openAddNewAccountWindow();
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: getIt<COADao>().getAll(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          c.languageFactory.getLang(0),
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          c.languageFactory.getLang(1),
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ),
                    ],
                    rows: [
                      ...snapshot.data!.map(
                        (e) => DataRow(
                          cells: [
                            DataCell(Text(e.code.toString())),
                            DataCell(Text(e.account)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        //     Container(height: 55, color: Colors.blue),
      ],
    );
  }

  //Dialog for confirming the user to delete and the data before importing the new chart of account
  Future<bool>
  asksUserConfirmationToBackupAndDeleteDataBeforeImportingNewChartOfAccount(
    BuildContext context,
  ) async {
    bool isOk = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Importing new chart of account will delete the current data. ",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                isOk = true;
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
    return isOk;
  }
}
