import 'package:flutter/material.dart';
import 'ApplicationConfig.dart';
import 'package:winter/winter.dart';
import './Home/HomeController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApplicationConfig().config().then((a) {
    runApp(getIt<HomeController>().view);
  });
}
