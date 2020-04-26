
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:todo/models/helpers/base_element.dart';
import 'package:todo/models/helpers/database_helper.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/models/style_object.dart';
import 'package:todo/utils/build_theme_data.dart';
import 'package:todo/utils/utils_colors.dart';
import 'package:todo/widgets/modal_text_widgets.dart';
import 'package:todo/widgets/my_widget_loading.dart';

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
  StreamController _streamController = StreamController();
  set _styleObjectStream(List<StyleObject> list) {
    _streamController.sink.add(list);
  }
  get _styleObjectStream => _streamController.stream;
  DatabaseHelper _databaseHelper;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _databaseHelper = new DatabaseHelper();
    initListStyleObject();
    menu = widget.menuObject;
    scaleAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 1000), lowerBound: 0.0, upperBound: 1.0);
    scaleAnimation.forward();

  }

  initListStyleObject()async{
    List<StyleObject> list = await _databaseHelper.getListStyle();
    _styleObjectStream = list;
  }
  @override
  void dispose() {
    super.dispose();
    scaleAnimation.dispose();
    _streamController?.close();
  }
  @override
  Widget build(BuildContext context) {
    if(textEditingController == null) textEditingController = TextEditingController(text: menu.getTitle(context));
    return Stack(
      children: <Widget>[
        Hero(
          tag: menu.id + "_background",
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
                gradient: menu.style.getLinear,
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
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
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    color: Colors.white,
                    onPressed:completed() ? ()=> _saveData() : null,
                  ),
                ),
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
                                      "The name",
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
                                      menu.getTitle(context),
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
                            backgroundColor: menu.style.color,
                            radius: 24,
                            child: Hero(
                              tag: menu.id + "_icon",
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: menu.style.color,
                                  border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    menu.icon,
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
                children: appListIcon.map((IconData icon){
                  int index = appListIcon.indexOf(icon);
                  bool isSelected = index == menu.iconId;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new GestureDetector(
                      onTap: (){
                        setState(() {
                          menu.iconId = index;
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
                        child: new Icon(icon),
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
              height: 100,
              child: _streamBuilder(),
            ),
          ),
          new WidgetEditStyle(
            widthMin: 50,
            widthMax: MediaQuery.of(context).size.width,
            heightMin: 50,
            heightMax: 180,
            onChanged: (List<Color> colors)async{
              StyleObject s = new StyleObject(colorStr: colorToHex(colors[0]),gradColor1: colorToHex(colors[1]),gradColor2: colorToHex(colors[2]));
              FireBaseElement element = await _databaseHelper.insert(s);
              setState(() {
                menu.styleId = element.id;
                menu.style = element;
              });
              initListStyleObject();
            },
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
                      menu.name = value;
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
  
  Widget _streamBuilder(){
    return new StreamBuilder(
      stream: _styleObjectStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData){
          return new Container();
        }
        List<StyleObject> list = snapshot.data;
        if (list.length == 0){
          return new MyWidgetNull(color: Colors.white,);
        }
        return new ListView(
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ...list.map((StyleObject style){
              bool isSelected = menu.style.colorStr == style.colorStr;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GestureDetector(
                  onTap: (){
                    setState(() {
                      menu.styleId = style.id;
                      menu.style = style;
                    });
                  },
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: style.getLinear,
                      border: Border.all(color:isSelected ? Colors.black : Colors.grey, style: BorderStyle.solid, width: 2.0),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: !isSelected && !style.isUsed
                        ?  new Align(
                      alignment: Alignment.topLeft,
                      child: new InkWell(
                        onTap: ()async{
                          print("delete");
                          await _databaseHelper.delete(style);
                          showInSnackBar("تم الحذف بنجاح");
                          initListStyleObject();

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Icon(Icons.delete ,color: Colors.white,),
                        ),
                      ),
                    )
                        : new Align(
                      alignment: Alignment.topLeft,
                      child: new InkWell(
                        onTap: (){
                          print("delete");
                          showInSnackBar("هذا الاستايل مستخدم بالفعل في أحد قوائمك");

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Icon(Icons.lock ,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.body2,
        )));
  }

  bool completed(){
    if(menu.name.length < 4){
      return false;
    }
    return true;
  }

  _saveData()async{
    print("_saveData");
    if(menu.id != null){
      await _databaseHelper.update(menu);
    }else{
      await _databaseHelper.insert(menu);
    }
    Navigator.pop(context, menu);

  }


}

class WidgetEditStyle extends StatefulWidget {
  final double widthMin;
  final double widthMax;
  final double heightMin;
  final double heightMax;
  final ValueChanged<List<Color>> onChanged;
  const WidgetEditStyle({Key key, this.widthMin, this.widthMax, this.heightMin, this.heightMax,@required this.onChanged}) : super(key: key);
  @override
  _WidgetEditStyleState createState() => _WidgetEditStyleState();
}

class _WidgetEditStyleState extends State<WidgetEditStyle> with SingleTickerProviderStateMixin{
  AnimationController controller;
  SequenceAnimation sequenceAnimation;

  bool forward;

  @override
  void initState() {
    super.initState();
    _listColors = colorsStander();
    controller = new AnimationController(vsync: this, duration: const Duration(seconds: 3));

    sequenceAnimation = new SequenceAnimationBuilder()
        .addAnimatable(
        animatable: new ColorTween(begin: Colors.red, end: Colors.white.withAlpha(70)),
        from:  const Duration(seconds: 0),
        to: const Duration(seconds: 4),
        tag: "color"
    ).addAnimatable(
        animatable: new Tween<double>(begin: widget.widthMin, end: widget.widthMin),
        from:  const Duration(seconds: 0),
        to: const Duration(milliseconds: 100),
        tag: "width",
        curve: Curves.easeIn
    ).addAnimatable(
        animatable: new Tween<double>(begin: widget.widthMin, end: widget.widthMax),
        from:  const Duration(milliseconds: 100),
        to: const Duration(milliseconds: 3700),
        tag: "width",
        curve: Curves.decelerate
    ).addAnimatable(
        animatable: new Tween<double>(begin: widget.heightMin, end: widget.heightMin),
        from:  const Duration(seconds: 0),
        to: const Duration(milliseconds: 100),
        tag: "height",
        curve: Curves.ease
    ).addAnimatable(
        animatable: new Tween<double>(begin: widget.heightMin, end: widget.heightMax),
        from:  const Duration(milliseconds: 100),
        to: const Duration(milliseconds: 3800),
        tag: "height",
        curve: Curves.decelerate
    ).animate(controller);


  }


  Future<Null> _playAnimation() async {
    try {
      await controller.forward().orCancel;
//      await controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }
  Future<Null> _closeAnimation() async {
    try {
//      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: (context, child) {
        return new Center(
          child: new Container(
            height: sequenceAnimation["height"].value,
            width: sequenceAnimation["width"].value,
            decoration: BoxDecoration(
                color: sequenceAnimation["color"].value,
                borderRadius: BorderRadius.circular(8),
              border: Border.all(),
            ),
            child:controller.value == 1.0
                ? editContainer()
                : stateContainer(),

          ),
        );
      },
      animation: controller,
    );
  }

  Widget stateContainer(){
    return controller.value == 0.0
        ? new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: new Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: new Icon(Icons.color_lens, size: 32,),
      ),
    )
        : new Container(

    );
  }

  Widget editContainer(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  color: Colors.white,
                  onPressed: (){
                    _closeAnimation();
                    setState(() {
                      _listColors = colorsStander();
                    });
                  },
                ),
                new MyTextBody(string: "قم باختيار الألوان",),
                new IconButton(
                  icon: new Icon(Icons.check),
                  color: Colors.white,
                  onPressed: completed() ? (){
                    widget.onChanged(_listColors);
                    _closeAnimation();
                    setState(() {
                      _listColors = colorsStander();
                    });
                  } : null,
                )

              ],
            ),
          ),
          new Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  colorCell(0,"الأساسي"),
                  colorCell(1,"اللون ١"),
                  colorCell(2,"اللون ٢"),
                  colorCell(3,"النتيجة",isEnd: true),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget colorCell(int index ,String title,{bool isEnd = false}){
    return new GestureDetector(
      onTap: ()async{
        if(isEnd) return;
        Color color = await circleColorPicker(context,title,_listColors[index]);
        if(color == null) return;
        print(color);
        _listColors.removeAt(index);
        setState(() {
          _listColors.insert(index, color);
        });
      },
      child: new Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Container(
                  height: 64,
                  width: 64,
                  decoration: isEnd 
                      ? BoxDecoration(
                    shape: BoxShape.rectangle ,
                    color: Colors.white ,
                    gradient: LinearGradient(colors: [_listColors[1],_listColors[2]], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    border: Border.all()
                  ) 
                      : BoxDecoration(
                      shape:  BoxShape.circle,
                      color: _listColors[index],
                      border: Border.all()
                  ),
                ),
              ),
              new Spacer(),
              new MyTextBody(string: title,),
              new Spacer(),
              new Spacer(),

            ],
          ),
      ),
    );
  }
  
  List<Color> _listColors = [];

  bool completed(){
    if(_listColors[0] == Colors.grey
        || _listColors[1] == Colors.grey
        || _listColors[2] == Colors.grey){
      return false;
    }
    return true;
  }

  List<Color> colorsStander(){
    return [
      Colors.grey,
      Colors.grey,
      Colors.grey,
    ];
  }



}

