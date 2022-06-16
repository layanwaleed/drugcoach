 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale{
  //take locale in the class
  Locale locale;

  //constructor
  AppLocale(this.locale);

  //to provide the object locale from the context
//when context changes we need to change the content
//based on that context

  //copy of app locale
  static AppLocale of(BuildContext context){
    return Localizations.of(context, AppLocale);
  }

//we need to download the content ( english or arabic )
    late Map<String, String> _loadedLocalizedValues;




//to download :
Future loadlanguage() async{
  String _langfile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
  Map<String , dynamic > _loadedValues = jsonDecode(_langfile);
  _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString()));
}

String? getTranslated(String? key){

  return _loadedLocalizedValues[key];
}

static const LocalizationsDelegate<AppLocale> delegate = _ApplocaleDelegate();


}


class _ApplocaleDelegate extends LocalizationsDelegate<AppLocale>{

  const _ApplocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    return [ "en" , "ar" ].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadlanguage();
    return appLocale;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) => false;
  
}