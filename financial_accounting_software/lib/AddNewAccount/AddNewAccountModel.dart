import 'package:winter/winter.dart';

class AddNewAccountModel implements WinterModel {
  void Function(void Function())? tableStateSetter;
  AddNewAccountModel(this.tableStateSetter);
}
