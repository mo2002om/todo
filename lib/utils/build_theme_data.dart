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

Color colorHex({String colorStr}) {
  return Color(getColorHexFromStr(colorStr));
}

int getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting a color");
    }
  }
  return val;
}

Color getTypeColor({int license}) {
  switch (license) {
    case 1:
      return Color(0xFFd8eff4);
    case 2:
      return Color(0xFFecf4dc);
    case 3:
      return Color(0xFF82d1dd);
    case 4:
      return Color(0xFF00ffff);
    case 5:
      return Color(0xFF98ff98);
    case 6:
      return Color(0xFF95aad7);
    case 7:
      return Color(0xFFffd700);
    case 8:
      return Color(0xFFc0c0c0);
    case 9:
      return Color(0xFFe4e3ec);
    default:
      return Color(0xFFffd700);
  }
}
