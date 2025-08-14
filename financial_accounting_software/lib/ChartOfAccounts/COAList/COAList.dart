import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './COAListController.dart';
import 'package:winter/winter.dart';

class COAList extends StatelessWidget {
  late final COAListController c;
  COAList() {}
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
                      DataColumn(
                        label: Text(
                          c.languageFactory.getLang(2),
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          c.languageFactory.getLang(3),
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
                            DataCell(
                              Text(e.isIncreaseInDebit ? "Debit" : "Credit"),
                            ),
                            DataCell(Text(e.isHidden.toString())),
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
        Container(height: 55, color: Colors.blue),
      ],
    );
  }
}
