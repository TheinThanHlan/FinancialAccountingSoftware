import 'package:flutter/material.dart';
import 'package:winter/winter.dart';

class ApplicationSettingsDao {
  Database _db = getIt<Database>(instanceName: "application_settings");
}
