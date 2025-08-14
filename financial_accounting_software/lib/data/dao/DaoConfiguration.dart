import 'package:financial_accounting_software/data/dao/GeneralJournalDao.dart';

import './COADao.dart';
import 'package:winter/winter.dart';

class DAOConfiguration implements Configurer {
  Future<void> config({String? instanceName}) async {
    getIt.registerSingleton(COADao());
    getIt.registerSingleton(GeneralJournalDao());
  }
}
