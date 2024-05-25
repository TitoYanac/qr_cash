// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/dao/local/preferences/preferences_auth_dao.dart';
import '../models/user/user.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String SPAIN = 'es';
const String FRENCH = 'fr';
const String HINDI = 'hi';
const String CHINESE = 'zh';

Future<Locale> setLocale(String languageCode) async {
  await PreferencesAuthDao().createRowData(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String languageCode = (User.getInstance().personData?.language=='')
      ? (preferences.getString(LANGUAGE_CODE) ?? ENGLISH)
      : User.getInstance().personData!.language;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, 'EN');
    case SPAIN:
      return const Locale(SPAIN, 'ES');
    case FRENCH:
      return const Locale(FRENCH, 'FR');
    case HINDI:
      return const Locale(HINDI, 'HI');
    case CHINESE:
      return const Locale(CHINESE, 'ZH');
    default:
      return const Locale(ENGLISH, 'US');
  }
}

AppLocalizations? translation(BuildContext context) {
  return AppLocalizations.of(context);
}
