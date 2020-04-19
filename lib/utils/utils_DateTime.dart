import 'package:flutter/material.dart';
import 'package:hijri/umm_alqura_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

import '../app_localizations.dart';
import 'package:intl/intl.dart';

Future<DateTime> rootDatePicker(
    {@required BuildContext context,
    @required int calendarId,
    bool isFree = false}) async {
  ummAlquraCalendar firstDate = new ummAlquraCalendar.now();
  if(isFree){
    firstDate = new ummAlquraCalendar()
      ..hYear = 1430
      ..hMonth = 09
      ..hDay = 8;
  }

  Future<DateTime> _showHJPicker({BuildContext context}) async {
    final ummAlquraCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: new ummAlquraCalendar.now(),
      lastDate: new ummAlquraCalendar()
        ..hYear = 1482
        ..hMonth = 9
        ..hDay = 25,
      firstDate: firstDate,
      locale: AppLocalizations.of(context).locale,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked == null) return null;
    DateTime dateTime = ummAlquraCalendar()
        .hijriToGregorian(picked.hYear, picked.hMonth, picked.hDay);
    return dateTime;
  }

  Future<DateTime> _showMLPicker({BuildContext context}) async {
    final DateTime _dTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: isFree ? DateTime(2000) : DateTime.now(),
        lastDate: DateTime(2100),
        locale: AppLocalizations.of(context).locale,
        initialDatePickerMode: DatePickerMode.day);
    return _dTime;
  }

  switch (calendarId) {
    case 0:
      return await _showMLPicker(context: context);
      break;
    case 1:
      return await _showHJPicker(context: context);
      break;
    default:
      return await _showMLPicker(context: context);
  }
}

String rootDateFull(
    {@required BuildContext context,
    @required int calendarId,
    @required DateTime dateTime}) {
  String _stringHJ() {
    var _format = new ummAlquraCalendar.fromDate(dateTime)
      ..currentLocale = AppLocalizations.of(context).locale.languageCode;
    return _format.toFormat("DDDD , dd , MMMM , yyyy");
  }

  String _stringML() {
    var format =
        DateFormat.yMMMMEEEEd(AppLocalizations.of(context).locale.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  switch (calendarId) {
    case 0:
      return _stringML();
      break;
    case 1:
      return _stringHJ();
      break;
    default:
      return _stringML();
  }
}

String rootDateMonth(
    {@required BuildContext context,
      @required int calendarId,
      @required DateTime dateTime}) {
  String _stringHJ() {
    var _format = new ummAlquraCalendar.fromDate(dateTime)
      ..currentLocale = AppLocalizations.of(context).locale.languageCode;
    return _format.toFormat("MMMM  yyyy");
  }

  String _stringML() {
    var format =
    DateFormat.yMMMM(AppLocalizations.of(context).locale.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  switch (calendarId) {
    case 0:
      return _stringML();
      break;
    case 1:
      return _stringHJ();
      break;
    default:
      return _stringML();
  }
}

Future<DateTime> rootDatePickerMonth(
    {@required BuildContext context,
      @required int calendarId,
      bool isFree = false}) async {
  ummAlquraCalendar firstDate = new ummAlquraCalendar.now();
  if(isFree){
    firstDate = new ummAlquraCalendar()
      ..hYear = 1430
      ..hMonth = 09
      ..hDay = 8;
  }

  Future<DateTime> _showHJPicker({BuildContext context}) async {
    final ummAlquraCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: new ummAlquraCalendar.now(),
      lastDate: new ummAlquraCalendar()
        ..hYear = 1482
        ..hMonth = 9
        ..hDay = 25,
      firstDate: firstDate,
      locale: AppLocalizations.of(context).locale,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked == null) return null;
    DateTime dateTime = ummAlquraCalendar()
        .hijriToGregorian(picked.hYear, picked.hMonth, picked.hDay);
    return dateTime;
  }

  Future<DateTime> _showMLPicker({BuildContext context}) async {
    final DateTime _dTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: isFree ? DateTime(2000) : DateTime.now(),
        lastDate: DateTime(2100),
        locale: AppLocalizations.of(context).locale,
        initialDatePickerMode: DatePickerMode.day);
    return _dTime;
  }

  switch (calendarId) {
    case 0:
      return await _showMLPicker(context: context);
      break;
    case 1:
      return await _showHJPicker(context: context);
      break;
    default:
      return await _showMLPicker(context: context);
  }
}

String rootDayCode(
    {@required BuildContext context,
      @required int calendarId,
      @required DateTime dateTime}) {
  String _stringHJ() {
    var _format = new ummAlquraCalendar.fromDate(dateTime)
      ..currentLocale = AppLocalizations.of(context).locale.languageCode;
    return _format.toFormat("m/d");
  }

  String _stringML() {
    var format =
    DateFormat.Md(AppLocalizations.of(context).locale.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  switch (calendarId) {
    case 0:
      return _stringML();
      break;
    case 1:
      return _stringHJ();
      break;
    default:
      return _stringML();
  }
}

String rootYearCode(
    {@required BuildContext context,
      @required int calendarId,
      @required DateTime dateTime}) {
  String _stringHJ() {
    var _format = new ummAlquraCalendar.fromDate(dateTime)
      ..currentLocale = AppLocalizations.of(context).locale.languageCode;
    return _format.toFormat("yyyy");
  }

  String _stringML() {
    var format =
    DateFormat.y(AppLocalizations.of(context).locale.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }
  switch (calendarId) {
    case 0:
      return _stringML();
      break;
    case 1:
      return _stringHJ();
      break;
    default:
      return _stringML();
  }
}