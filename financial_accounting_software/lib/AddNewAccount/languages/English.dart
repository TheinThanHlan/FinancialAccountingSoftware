import 'package:financial_accounting_software/Language.dart';
import 'package:winter/winter.dart';

class English implements Language {
  @override
  List<String> get content => const [
    "Create New Account", //0
    "Account name", //1
    "Please enter the account name", //2
    "Code", //3
    "Please enter the standardized code of account", //4
    "Please follow the standard chart of account rules", //5
    "Chart of account cannot lower than 10000 and higher than 99999", //5
    "Debit account?", //6
    "Credit account?", //7
    "Create", //8
  ];
}
