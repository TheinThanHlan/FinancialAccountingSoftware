import 'package:financial_accounting_software/AddNewAccount/all.dart';
import 'package:financial_accounting_software/ChartOfAccount/all.dart';
import 'package:financial_accounting_software/GeneralJournal/all.dart';
import 'package:financial_accounting_software/GeneralLedger/GeneralLedgerComponentConfig.dart';
import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/JournalDetails/JournalDetailsComponentConfig.dart';
import 'package:financial_accounting_software/SayHello/all.dart';
import 'package:financial_accounting_software/data/dao/DaoConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:winter/winter.dart';
import './Home/HomeComponentConfig.dart';
import 'package:winter/components/TableWithStickyHeader/all.dart';

class ApplicationConfig implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    getIt.registerSingleton<GlobalStyle>(GlobalStyle());
    getIt.registerSingleton<ValueNotifier<String>>(
      ValueNotifier("en"),
      instanceName: "currentLanguage",
    );
    String accountingDb = "accounting_db";
    getIt.registerSingletonAsync(() async {
      var dbp = WinterSqliteDatabaseProvider(accountingDb, 1, [
        "resources/Scripts/create_databases.sql",
        "resources/Scripts/insert_chart_of_accounts.sql",
      ]);
      await dbp.createDb();
      return dbp;
    }, instanceName: accountingDb);

    await getIt.isReady<WinterSqliteDatabaseProvider>(
      instanceName: accountingDb,
    );

    await AddNewAccountComponentConfig().config();
    await SayHelloComponentConfig().config();
    await TableWithStickyHeaderComponentConfig().config();
    await ChartOfAccountComponentConfig().config();
    await JournalDetailsComponentConfig().config();
    await DAOConfiguration().config();
    await GeneralJournalComponentConfig().config();
    await GeneralLedgerComponentConfig().config();
    await HomeComponentConfig().config();
  }
}
