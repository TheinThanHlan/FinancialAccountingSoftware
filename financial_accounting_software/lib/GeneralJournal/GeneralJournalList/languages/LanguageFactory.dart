import "English.dart";
import 'package:winter/winter.dart';
import 'package:flutter/foundation.dart';

class LanguageFactory {
  Map<String, Language> _languages = {"en": English()};
  ValueNotifier<String> _currentLanguage;
  LanguageFactory(this._currentLanguage);

  String getLang(int index) {
    return (_languages[this._currentLanguage.value] ?? _languages["en"])!
        .content[index];
  }
}
