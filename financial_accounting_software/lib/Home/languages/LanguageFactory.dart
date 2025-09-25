import "English.dart";
import "Myanmar.dart";
import 'package:winter/winter.dart';
import 'package:flutter/foundation.dart';

class LanguageFactory {
  final Map<String, Language> _languages = {"en": English(), "mm": Myanmar()};
  final ValueNotifier<String> _currentLanguage;
  LanguageFactory(this._currentLanguage);

  String getLang(int index) {
    return (_languages[_currentLanguage.value] ?? _languages["en"])!.content[index];
  }
}
