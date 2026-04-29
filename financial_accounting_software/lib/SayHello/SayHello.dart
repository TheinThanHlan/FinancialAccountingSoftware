import 'package:flutter/material.dart';
import 'package:winter/winter.dart';
import "SayHelloModel.dart";

class SayHello extends StatelessWidget implements WinterView {
  //late final SayHelloController c;
  final WinterLanguageFactory _lf;
  final SayHelloModel _model;
  const SayHello(this._lf, this._model);
  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return Container();
  }
}
