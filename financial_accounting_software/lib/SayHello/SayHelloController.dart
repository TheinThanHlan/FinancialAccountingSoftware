import 'SayHelloModel.dart';
import 'SayHello.dart';
import 'package:winter/winter.dart';

class SayHelloController implements WinterController {
  final SayHelloModel _model;
  final SayHello _view;
  final WinterLanguageFactory _lf;
  //final module = getIt<GetIt>(instanceName:);
  const SayHelloController(this._view, this._lf, this._model);
  //this._view.c=this;
  void reset() {}

  WinterView getView() {
    return this._view;
  }
}
