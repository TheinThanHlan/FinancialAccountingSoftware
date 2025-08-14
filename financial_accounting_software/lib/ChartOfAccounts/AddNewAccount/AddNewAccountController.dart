import 'AddNewAccountModel.dart';
import 'AddNewAccount.dart';
import 'languages/LanguageFactory.dart';
import 'package:winter/winter.dart';
import 'package:flutter/widgets.dart';

class AddNewAccountController implements WinterController {
  late final AddNewAccountModel? data;
  late final AddNewAccount view;
  late final LanguageFactory languageFactory;
  late final Map<String, bool> debitAndCredit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ValueNotifier<String> debitOrCredit;

  //final module = getIt<GetIt>(instanceName:);
  AddNewAccountController(this.view, this.languageFactory, {this.data}) {
    this.view.c = this;
    this.debitAndCredit = {
      this.languageFactory.getLang(7): true,
      this.languageFactory.getLang(8): false,
    };
    debitOrCredit = ValueNotifier<String>(debitAndCredit.keys.first);
  }
  String greet = "Hello from AddNewAccountPage";
  void reset() {}

  Widget getView() {
    return this.view;
  }
}
