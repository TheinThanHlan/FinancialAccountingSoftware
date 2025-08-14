import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GlobalStyle {
  final Color primaryColor = Color.fromARGB(80, 224, 224, 224);
  final Color secondaryColor = Color.fromARGB(80, 224, 224, 224);
  final Color backgroundColor = Color.fromARGB(80, 224, 224, 224);
  final Color sideBarColor = Color.fromARGB(100, 224, 224, 224);
  final double topBarHeight = 55;

  TextStyle dangerLabel(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.red);
  TextStyle successLabel(BuildContext context) => Theme.of(
    context,
  ).textTheme.labelMedium!.copyWith(color: Colors.lightGreen);
}
