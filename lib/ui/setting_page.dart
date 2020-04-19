
import 'package:flutter/material.dart';
import 'package:todo/models/tools.dart';
import 'package:todo/utils/language.dart';
import 'package:todo/widgets/modal_text_widgets.dart';


import '../app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final Tools tools;
  const SettingsPage({Key key, this.tools}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(getTranslated(context,"settings")),
      ),
      body: body(),
    );
  }
  Widget body(){
    return new GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: new Column(
                children: <Widget>[
                  new MyTextBody(string: getTranslated(context,"languageTitle"),),
                  new Column(
                    children: Language.languageList().map((Language lang){
                      bool isCheck = widget.tools.languageId == lang.id;


                      return new Card(
                        child: new ListTile(
                          onTap: (){
                            print(widget.tools.languageId);
                            print("_tools == ${lang.id}");
                            Tools t = widget.tools;
                            t.languageId = lang.id;
                            t.languageFlag = lang.flag;
                            t.languageName = lang.name;
                            t.languageCode = lang.languageCode;
                            bloc.update(tools: t);
                          },
                          title: new MyTextBody(string: getTranslated(context, lang.name),textAlign: TextAlign.center),
//                          subtitle: new MyTextBody(string: lang.flag,),
                          leading:  new Container(
                            height: 32,
                            width: 32,
                            child: isCheck ? new Icon(Icons.check) : new Container(
                              width: 32,
                            ),
                          ),
                          trailing: new Text(lang.flag,textAlign: TextAlign.left,style: TextStyle(fontSize: 24),),
                        ),
                      );
                    }).toList(),
                  )

                ],
              ),
            ),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: new Column(
                children: <Widget>[
                  new MyTextBody(string: getTranslated(context, "calendar"),),
                  new Column(
                    children: Calendar.calendarList().map((Calendar cale){
                      bool isCheck = widget.tools.calendarId == cale.id;
                      return new Card(
                        child: new ListTile(
                          onTap: (){
                            Tools t = widget.tools;
                            t.calendarId = cale.id;
                            bloc.update(tools: t);
                          },
                          title: new MyTextBody(string: getTranslated(context, cale.key),textAlign: TextAlign.center),
//                          subtitle: new MyTextBody(string: lang.flag,),
                          leading:  new Container(
                            height: 32,
                            width: 32,
                            child: isCheck ? new Icon(Icons.check) : new Container(
                              width: 32,
                            ),
                          ),
                          trailing: Container(
                              height: 32,
                              width: 32,
                              child: new Icon(Icons.language)),
                        ),
                      );
                    }).toList(),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}