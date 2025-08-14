import 'package:financial_accounting_software/ChartOfAccounts/AddNewAccount/all.dart';
import 'package:financial_accounting_software/ChartOfAccounts/COAList/COAListController.dart';
import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ChartOfAccountsController.dart';
import 'package:winter/winter.dart';

class ChartOfAccounts extends StatelessWidget {
  late final ChartOfAccountsController c;
  ChartOfAccounts();
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
