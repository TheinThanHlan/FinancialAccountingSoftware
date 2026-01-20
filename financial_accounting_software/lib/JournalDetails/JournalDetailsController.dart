import 'JournalDetailsModel.dart';
import 'JournalDetails.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'package:flutter/widgets.dart';

class JournalDetailsController implements WinterController {
  late final JournalDetailsModel? data;
  late final JournalDetails view;
  late final LanguageFactory languageFactory;
  //final module = getIt<GetIt>(instanceName:);
  JournalDetailsController(this.view,this.languageFactory,{this.data}){
   view.c=this;
  }
  String greet = "Hello from JournalDetailsPage";
  void reset(){}

  @override
  Widget getView(){
    return view;
  }

}
