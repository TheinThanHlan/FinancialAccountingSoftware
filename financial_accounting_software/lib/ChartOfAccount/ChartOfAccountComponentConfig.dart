import 'languages/JapanLanguageMap.dart';
import 'ChartOfAccountController.dart';
import 'ChartOfAccountModel.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

class ChartOfAccountComponentConfig implements Configurer {
  //please write sub component configurations here
  Future<void> _preConfig() async {}

  Future<void> config({String? instanceName}) async {
    await _preConfig();

    //Lazy Singleton injection
    getIt.registerLazySingleton(
      instanceName: instanceName,
      () => ChartOfAccountController(
        //ChartOfAccount(),
        WinterLanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
          {"jp": JapanLanguageMap()},
        ),
        ChartOfAccountModel(),
      ),
    );

    //Factory injection with parameter
    /*
  getIt.registerFactoryParam<ChartOfAccountController,ChartOfAccountModel,Null>(instanceName:instanceName,(p1,p2)=>ChartOfAccountController(

    //ChartOfAccount(), 
   WinterLanguageFactory(
    getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
    {"jp":JapanLanguageMap()}
    ),
    p1

   ),);

  */

    await _postConfig();
  }

  //please write the tasks you want to do after config here
  Future<void> _postConfig() async {
    debugPrint("\t~>\tChartOfAccountComponent injected;");
  }
}
