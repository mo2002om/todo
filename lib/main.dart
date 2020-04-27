import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/ui/root_page.dart';

import 'app_localizations.dart';
import 'models/tools.dart';
import 'utils/build_theme_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Tools _tools;
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<Tools>(
      stream: bloc.streamTools,
      initialData: Tools.getTools(),
      builder: (context, snapshot) {
        _tools = snapshot.data;
        return new MaterialApp(
          locale: _tools.selectedLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ar', 'SA'), // Arabic
            const Locale('en', 'US'), // English
          ],
          localeResolutionCallback: (locale,supportedLocales){
            if(locale!=null){
              for(var supportedLocale in supportedLocales){
                if(locale!=null && supportedLocale.languageCode == locale.languageCode
                    && supportedLocale.countryCode == locale.countryCode){
                  return supportedLocale;
                }
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          theme: _tools.languageId == 0 ? buildThemeDataAr() : buildThemeDataEn(),
//          theme: myTheme,
          home: new RootPage(
            tools: _tools,
          ),
        );
      },
    );
  }
}

/*
keytool -genkey -v -keystore ~/organize.jks -keyalg RSA -keysize 2048 -validity 20000 -alias key
flutter build apk --release
Built build/app/outputs/apk/release/app-release.apk
flutter build ios --release
Built /Users/mousaalfifi/Desktop/Flutter/MyTesting/tahssel/build/ios/iphoneos/Runner.app.

key password Awos2007

keytool -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore



keytool -list -v -keystore /Users/mousaalfifi/Desktop/appsKeys/nawarKeyAndroid/key.jks -alias key

69:75:42:36:27:01:B6:5B:98:91:2D:B4:18:0F:DE:62:4D:CE:9D:DA

4A:BE:C8:81:E6:FE:AE:E8:4F:98:9B:9A:BC:B4:1D:6B:F3:77:2F:37:55:81:D0:63:9A:25:DC:14:03:D1:56:BA

 SHA256: C6:3D:C2:CA:F9:9B:3E:35:17:CE:FE:07:FA:44:ED:AA:7C:06:12:97:13:D5:B8:D9:FE:3D:FE:A5:55:9F:EE:E2



 */

