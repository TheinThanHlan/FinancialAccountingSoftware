import 'package:financial_accounting_software/data/dao/AccountTypeDao.dart';
import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';
import 'package:financial_accounting_software/data/dao/GeneralLedgerDao.dart';

import './COADao.dart';
import 'package:winter/winter.dart';

class DAOConfiguration implements Configurer {
  @override
  Future<void> config({String? instanceName}) async {
    var accounting_db = getIt<WinterSqliteDatabaseProvider>(
      instanceName: "accounting_db",
    ).getDb();
    getIt.registerSingleton(COADao());
    getIt.registerSingleton(GeneralJournalDao());
    getIt.registerSingleton(AccountTypeDao(accounting_db));
    getIt.registerSingleton(GeneralLedgerDao(accounting_db));
  }
}
