
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hijri/umm_alqura_calendar.dart';

import '../app_localizations.dart';
import 'package:intl/intl.dart';


String createId(){
  var uuid = Uuid();
  String format = formatId(input: uuid.v1());
  return format;
}

String formatId({String input}) {
  String stringNew = "";
  if (input.length == 0){
    return "";
  }
  final _delimiter = '-';
  final _values = input.split(_delimiter);
  _values.forEach((item) {
    stringNew += item;
  });
  return stringNew;
}

String getDayId() {
  int year = new DateTime.now().year;
  int day = new DateTime.now().day;
  int month = new DateTime.now().month;
  String string = year.toString() + month.toString() + day.toString() ;
  return string;
}

int getPushId({int timestamp}) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  int day = date.day;
  int hour = date.hour;
  int minute = date.minute;
  int second = date.second;
  String string = day.toString() + hour.toString() + minute.toString() + second.toString();
  print(int.parse(string));
  return int.parse(string);
}
String getDayIdWithDateTime({DateTime dateTime}) {
  int year = dateTime.year;
  int day = dateTime.day;
  int month = dateTime.month;
  String string = year.toString() + month.toString() + day.toString() ;
  return string;
}
String getMonthId() {
  int year = new DateTime.now().year;
  int month = new DateTime.now().month;
  String string = year.toString() + month.toString() ;
  return string;
}

String getHijriDate(){
  ummAlquraCalendar _today = new ummAlquraCalendar.now();
  _today.currentLocale = 'ar';
  print(_today.hYear); // 1439
  print(_today.hMonth); // 9
  print(_today.hDay); // 14
  print(_today.hDay); // 14
  print(_today.dayWeName);
  // Get month length in days
  print(_today.lengthOfMonth); // 30 days
  print(_today.toFormat("MMMM dd yyyy")); //Ramadan 14 1439
  print(" 10 months from now ${new ummAlquraCalendar.addMonth(1440, 12)
      .fullDate()}"); //Ramadan 14 1439

  //From Gregorian to Ummalqura
  var h_date = new ummAlquraCalendar.fromDate(new DateTime(2018, 11, 12));

  print(h_date.fullDate()); //04/03/1440H
  print(h_date.shortMonthName); //Rab1
  print(h_date.longMonthName); //Rabi' al-awwal
  print(h_date.lengthOfMonth); // 29 days

  // check date is valid
  var _check_date = new ummAlquraCalendar()
    ..hYear = 1430
    ..hMonth = 09
    ..hDay = 8
    ..currentLocale = 'ar';
  print(_check_date.isValid()); // false -> This month is only 29 days
  print(_check_date.fullDate()); // false -> This month is only 29 days

  //From Ummalqura to Gregorian
  var g_date = new ummAlquraCalendar();
  print(g_date.hijriToGregorian(1440, 4, 19).toString()); //1994-12-29 00:00:00.000

  //Format
  var _format = new ummAlquraCalendar.now()..currentLocale = 'ar';

  print(_format.fullDate()); //Thulatha, Ramadan 14, 1439 h
  print(_format.toFormat("mm dd yy")); //09 14 39
  print(_format.toFormat("-- DD, MM dd --")); //09 14 39

  //Compare
  //Suppose current hijri data is: Thulatha, Ramadan 14, 1439 h
  print(_today.isAfter(1440, 11, 12)); // false
  print(_today.isBefore(1440, 11, 12)); // true
  print(_today.isAtSameMomentAs(1440, 11, 12));

  return _format.toFormat("DDDD , dd , MMMM , yyyy هـ");
}
String getHijriDayFull(){
  var _format = new ummAlquraCalendar.now()..currentLocale = 'ar';
  return _format.toFormat("DDDD , dd , MMMM , yyyy هـ");
}
String getNameDay({int timestamp,BuildContext context}) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  var time = getTranslated(context,"SUNDAY");
  if(date.weekday == 0){
    time = getTranslated(context,"SUNDAY");
  }else if(date.weekday == 1){
    time = getTranslated(context,"MONDAY");
  }else if(date.weekday == 2){
    time = getTranslated(context,"TUESDAY");
  }else if(date.weekday == 3){
    time = getTranslated(context,"WEDNESDAY");
  }else if(date.weekday == 4){
    time = getTranslated(context,"THURSDAY");
  }else if(date.weekday == 5){
    time = getTranslated(context,"FRIDAY");
  }else if(date.weekday == 6){
    time = getTranslated(context,"SATURDAY");
  }
  return time;
}

String getMissionTime({int timestamp}){
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  DateFormat dateFormat = DateFormat('HH:mm');
  return dateFormat.format(date);
}

String getHijriWithDateTime(DateTime dateTime){
  var _format = new ummAlquraCalendar.fromDate(dateTime)..currentLocale = 'ar';
  return _format.toFormat("DDDD / dd / MMMM / yyyy هـ");
}

