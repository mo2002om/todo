
import 'package:flutter/material.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/models/style_object.dart';
import 'package:todo/utils/utils_colors.dart';
import 'package:todo/utils/utils_string.dart';

import '../app_localizations.dart';

class EditMenuPage extends StatefulWidget {
  final MenuObject menuObject;
  const EditMenuPage({Key key, this.menuObject}) : super(key: key);

  @override
  _EditMenuPageState createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> with TickerProviderStateMixin{
  MenuObject menu;
  AnimationController scaleAnimation;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    menu = widget.menuObject;
    textEditingController = TextEditingController(text: menu.name);
    scaleAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 1000), lowerBound: 0.0, upperBound: 1.0);
    scaleAnimation.forward();

  }
  @override
  void dispose() {
    super.dispose();
    scaleAnimation.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: menu.id + "_background",
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
                gradient: menu.theme.getLinear,
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            backgroundColor: menu.theme.color,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: Hero(
                tag: menu.id + "_backIcon",
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only( top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 4.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Hero(
                                  tag: menu.id + "_number_of_tasks",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      menu.tasks.length.toString() + getTranslated(context, "tasks"),
                                      style: TextStyle(),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 4.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Hero(
                                  tag: menu.id + "_title",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      getTranslated(context, menu.name),
                                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        new Spacer(),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: new CircleAvatar(
                            backgroundColor: menu.theme.color,
                            radius: 24,
                            child: Hero(
                              tag: menu.id + "_icon",
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: menu.theme.color,
                                  border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    menu.theme.icon,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: Hero(
                        tag: menu.id + "_just_a_test",
                        child: Material(
                          type: MaterialType.transparency,
                          child: FadeTransition(
                            opacity: scaleAnimation,
                            child: ScaleTransition(
                              scale: scaleAnimation,
                              child: widgetEditMenu(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetEditMenu(){
    return new Container(
      child: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 0),
            child: Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "الإيقونة",
                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                  softWrap: false,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0,top: 10),
            child: Container(
              height: 60,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: ListThemeMenu.choices.map((ThemeMenu theme){
                  bool isSelected = menu.style.iconId == theme.iconId;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new GestureDetector(
                      onTap: (){
                        setState(() {
                          menu.style.iconId = theme.iconId;
                        });
                      },
                      child: new Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: isSelected ? Colors.black : Colors.grey, style: BorderStyle.solid, width: 2.0),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: new Icon(theme.icon),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 0),
            child: Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "الاستايل",
                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                  softWrap: false,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10,top: 10),
            child: Container(
              height: 84,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: ListThemeMenu.choices.map((ThemeMenu theme){
                  bool isSelected = menu.style.colorStr == theme.getColorStr;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new GestureDetector(
                      onTap: (){
                        setState(() {
                          menu.style.gradColor1 = theme.getGradColor1;
                          menu.style.gradColor2 = theme.getGradColor2;
                          menu.style.colorStr = theme.getColorStr;
                        });
                      },
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:isSelected ? Colors.black : Colors.grey, style: BorderStyle.solid, width: 2.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Column(
                            children: <Widget>[
                              new Expanded(
                                flex: 6,
                                child: Container(
                                  color: theme.color,
                                ),
                              ),
                              new Expanded(
                                flex: 3,
                                child: Container(
                                  color: theme.gradient[0],
                                ),
                              ),

                              new Expanded(
                                flex: 3,
                                child: Container(
                                  color: theme.gradient[1],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 10),
            child: Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "اسم القائمة",
                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                  softWrap: false,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(70),
                border: Border.all(color: Colors.black.withAlpha(70),),
                borderRadius: BorderRadius.circular(16)

            ),
            child: new Align(
              alignment: Alignment.center,
              child: new Material(
                color: Colors.transparent,
                child: TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  onChanged: (String value){
                    setState(() {
                    });
                  },
                  style: TextStyle(
                      color: Colors.black,
                      textBaseline: TextBaseline.alphabetic
                  ),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, "createMission"),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
