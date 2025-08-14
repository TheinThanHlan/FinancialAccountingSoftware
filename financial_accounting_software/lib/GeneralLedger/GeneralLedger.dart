import 'package:flutter/material.dart';
import './GeneralLedgerController.dart';
import 'package:winter/winter.dart';

class GeneralLedger extends StatelessWidget {
  late final GeneralLedgerController c;
  GeneralLedger();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(color: Colors.red);
      },
    );
  }
}
