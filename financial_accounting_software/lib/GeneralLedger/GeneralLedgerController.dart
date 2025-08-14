import 'GeneralLedgerModel.dart';
import 'GeneralLedger.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';

class GeneralLedgerController {
  late final GeneralLedgerModel? data;
  late final GeneralLedger view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);
  GeneralLedgerController(this.view,this.languageFactory,{this.data}){
   this.view.c=this;
  }
  String greet = "Hello from GeneralLedgerPage";
  void reset(){}
}
