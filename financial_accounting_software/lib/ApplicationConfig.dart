import 'package:financial_accounting_software/ChartOfAccounts/all.dart';
import 'package:financial_accounting_software/GeneralJournal/all.dart';
import 'package:financial_accounting_software/GeneralLedger/GeneralLedgerComponentConfig.dart';
import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/DaoConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:winter/winter.dart';
import './Home/HomeComponentConfig.dart';

class ApplicationConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    getIt.registerSingleton<GlobalStyle>(GlobalStyle());
    getIt.registerSingleton<ValueNotifier<String>>(
      ValueNotifier("en"),
      instanceName: "currentLanguage",
    );

    String accounting_db = "accounting_db";
    getIt.registerSingletonAsync(
      () async => WinterSqliteDatabaseProvider(accounting_db, 1, [
        "resources/Scripts/create_databases.sql",
        "resources/Scripts/insert_chart_of_accounts.sql",
      ]).getDatabase(),
      instanceName: accounting_db,
    );
    await getIt.isReady<Database>(instanceName: accounting_db);
    DAOConfiguration().config();
    GeneralJournalComponentConfig().config();
    GeneralLedgerComponentConfig().config();
    ChartOfAccountsComponentConfig().config();
    HomeComponentConfig().config();
  }
}
