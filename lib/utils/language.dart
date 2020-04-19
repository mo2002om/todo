
import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  Language({this.id, this.name, this.flag, this.languageCode});

  static List<Language> languageList(){
    return <Language>[
      new Language(id: 0,name: "Arabic",flag: "🇸🇦",languageCode: "ar"),
      new Language(id: 1,name: "English",flag: "🇺🇸",languageCode: "en"),

    ];
  }

  static Locale getLocale({Language lang}) {
    switch(lang.languageCode){
      case "ar":
        return Locale(lang.languageCode,"SA");
        break;
      case "en":
        return Locale(lang.languageCode,"US");
        break;
      default:
        return Locale("ar","SA");
    }
  }
}

class Calendar {
  final int id;
  final String key;
  Calendar({this.id, this.key});

  static List<Calendar> calendarList(){
    return <Calendar>[
      new Calendar(id: 0,key: "ML"),
      new Calendar(id: 1,key: "HJ"),
    ];
  }
}