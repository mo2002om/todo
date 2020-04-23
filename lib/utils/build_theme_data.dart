import 'package:flutter/material.dart';

class AppColors {
  static const mainColor = Color(0xFF6AA452);
  static const lightMainColor = Color(0xFF86B76A);
}

const primaryColor = const Color(0xff203152);
const kPrimaryDark = Colors.teal;
const kPrimaryLight = const Color(0xFFf6c76e);
const kScaffoldBackgroundColor = const Color(0xFFfdf5c9);

const kPrimaryColor = const Color(0xFFdc716d);
const kButtonColor = const Color(0xFFf6c76e);
const themeColor = const Color(0xfff5a623);
const greyColor = const Color(0xffe5f4f3);
const greyColor2 = const Color(0xffE8E8E8);
const greyColor3 = const Color(0xff00ced1);

const kColor1 = const Color(0xFF6b3e26);
const kColor2 = const Color(0xFFffc5d9);
const kColor3 = const Color(0xFFc2f2d0);
const kColor5 = const Color(0xFFffcb85);
const String appName = "إنجازاتي";

const primarySwatch = const MaterialColor(
  4280361249,
  {
    50: Color(0xfff2f2f2),
    100: Color(0xfffaefec),
    200: Color(0xfff5e0d9),
    300: Color(0xfff0d1c6),
    400: Color(0xffebc2b4),
    500: Color(0xffe7b3a1),
    600: Color(0xffe2a38e),
    700: Color(0xffdd947c),
    800: Color(0xffd88569),
    900: Color(0xffcf6744)
  },
);
//fb6d79
ThemeData buildThemeDataAr() {
  final baseTheme = ThemeData(
    fontFamily: "cairo",
    textTheme: TextTheme(),
    primarySwatch: Colors.deepOrange,
  );

  return baseTheme.copyWith(
//    primaryColor: Color(0xffd3e1ed)

      );
}

ThemeData buildThemeDataEn() {
  final baseTheme = ThemeData(
    fontFamily: "opensans",
    textTheme: TextTheme(),
    primarySwatch: Colors.deepOrange,
  );

  return baseTheme.copyWith(
//    primaryColor: Color(0xffd3e1ed)
      );
}

Color hexToColor(String code) {
  return HexColor.fromHex(code);
}

String colorToHex(Color value) {
  return value.toHex();
}


//class HexColor {
//  static Color fromHex(String hexString) {
//    final buffer = StringBuffer();
//    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//    buffer.write(hexString.replaceFirst('#', ''));
//    return Color(int.parse(buffer.toString(), radix: 16));
//  }
//  static String toHex({bool leadingHashSign = true , Color value}) => '${leadingHashSign ? '#' : ''}'
//      '${value.alpha.toRadixString(16).padLeft(2, '0')}'
//      '${value.red.toRadixString(16).padLeft(2, '0')}'
//      '${value.green.toRadixString(16).padLeft(2, '0')}'
//      '${value.blue.toRadixString(16).padLeft(2, '0')}';
//
//}



extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

