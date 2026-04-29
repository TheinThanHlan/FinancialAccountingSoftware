import 'languages/JapanLanguageMap.dart';
import 'SayHelloController.dart';
import 'SayHelloModel.dart';
import 'SayHello.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

class SayHelloComponentConfig implements Configurer {
  final String? instanceName;
  const SayHelloComponentConfig({this.instanceName});

  //please write sub component configurations here
  Future<void> _preConfig() async {}

  Future<void> config() async {
    await _preConfig();

    var lf = WinterLanguageFactory(
      getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
      {"jp": JapanLanguageMap()},
    );

    //Lazy Singleton injection
    getIt.registerLazySingleton(instanceName: instanceName, () {
      var model = SayHelloModel();
      var view = SayHello(lf, model);
      return SayHelloController(
        //SayHello(),
        view,
        lf,
        model,
      );
    });
    //Factory injection with parameter
    /*
  getIt.registerFactoryParam<SayHelloController,SayHelloModel,Null>(instanceName:instanceName,(p1,p2)=>SayHelloController(
    
    SayHello(lf,p1), 
    lf,
    p1

   ),);

  */
    await _postConfig();
  }

  //please write the tasks you want to do after config here
  Future<void> _postConfig() async {
    debugPrint("\t~>\tSayHelloComponent injected;");
  }
}
