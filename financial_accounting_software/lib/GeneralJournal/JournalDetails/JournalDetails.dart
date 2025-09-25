import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:flutter/material.dart';
import './JournalDetailsController.dart';
import 'package:winter/winter.dart';

class JournalDetails extends StatelessWidget {
  late final JournalDetailsController c;
  @override
  Widget build(BuildContext context) {
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
                      ListTile(title: Text('Date'), subtitle: Text('1/1/2023')),
                      ListTile(title: Text('Time'), subtitle: Text('01:30')),
                    ],
                  ),
                ),
                Flexible(
                  child: ListTile(
                    title: Text('Description'),
                    subtitle: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud e',
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(width: double.maxFinite, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
