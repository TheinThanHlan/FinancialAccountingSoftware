import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';
import 'package:flutter/material.dart';
import './JournalDetailsController.dart';
import 'package:winter/winter.dart';

class JournalDetails extends StatelessWidget implements WinterView {
  late final JournalDetailsController c;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<GeneralJournalDao>().getWithId(c.data!.journalId),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Journal Details',
              style: getIt<GlobalStyle>().titleTextStyle(context),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 244,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Date'),
                            subtitle: Text(
                              """${snapshot.data!.journalDate.day}/${snapshot.data!.journalDate.month}/${snapshot.data!.journalDate.year}""",
                            ),
                          ),
                          ListTile(
                            title: Text('Time'),
                            subtitle: Text(
                              """${snapshot.data!.journalDate.hour}:${snapshot.data!.journalDate.minute}""",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: Text('Description'),
                        subtitle: Text(
                          snapshot.data!.description,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text("Particulars")),
                          DataColumn(label: Text("Debit")),
                          DataColumn(label: Text("Credit")),
                        ],
                        rows: snapshot.data!.entries.map((a) {
                          return DataRow(
                            cells: [
                              DataCell(Text(a.affectedAccount.account)),
                              DataCell(
                                Text(a.isDebit ? a.amount.toString() : "0"),
                              ),
                              DataCell(
                                Text(!a.isDebit ? a.amount.toString() : "0"),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    /*
                    Container(
                      width: double.maxFinite,
                      height: 10000,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color(0xff1f005c),
                            Color(0xff5b0060),
                            Color(0xff870160),
                            Color(0xffac255e),
                            Color(0xffca485c),
                            Color(0xffe16b5c),
                            Color(0xfff39060),
                            Color(0xffffb56b),
                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                      ),
                    ),*/
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
