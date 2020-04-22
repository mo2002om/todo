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
git add .
git commit -m "update tody"
git push -u origin master
 */

