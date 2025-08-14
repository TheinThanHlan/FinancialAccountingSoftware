import 'package:winter/winter.dart';

class COAListModel implements WinterModel {
  void Function() openAddNewAccountWindow;
  COAListModel(this.openAddNewAccountWindow);
}
