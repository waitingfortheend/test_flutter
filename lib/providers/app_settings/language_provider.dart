import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_diversition/models/app_setting_model.dart';
import '../../../enum/headings.dart';
import '../../../enum/locale_type.enum.dart';
import '../../../utility/app_local_storage_until.dart';

class LanguageProvider extends ChangeNotifier {
  LocaleType _language = LocaleType.th;
  LocaleType get language => _language;
  List<LocaleType> listLocaleType = [LocaleType.th, LocaleType.en];
  Map<LocaleType, String> mapLocaleName = {
    LocaleType.th: 'ภาษาไทย',
    LocaleType.en: 'English',
  };
  Map<LocaleType, Locale> listLocale = {
    LocaleType.th: const Locale('th', 'TH'),
    LocaleType.en: const Locale('en', 'EN'),
  };

  set language(LocaleType value) {
    _language = value;
    _save();
    notifyListeners();
  }

  get localeName => mapLocaleName[_language];

  get locale => listLocale[_language];

  load() async {
    var data = await LocalStorage.getLocalStorage(
      key: AppSettingModel.jsonName,
    );
    data ??= AppSettingModel(FontType.normal, LocaleType.th).toJson();
    var model = AppSettingModel.fromJson(data);
    _language = model.language;

    if (kDebugMode) {
      print("get language ==> ${model.language.name}");
    }
  }

  _save() async {
    var data = await LocalStorage.getLocalStorage(
      key: AppSettingModel.jsonName,
    );
    data ??= AppSettingModel(FontType.normal, LocaleType.th).toJson();
    var model = AppSettingModel.fromJson(data);
    model.language = _language;
    await LocalStorage.setLocalStorage(
      key: AppSettingModel.jsonName,
      object: model.toJson(),
    );
  }
}
