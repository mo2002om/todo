
import 'dart:async';

import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/cells/menu_object_cell.dart';
import 'package:todo/models/helpers/database_helper.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/models/task_object.dart';
import 'package:todo/models/tools.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/utils_DateTime.dart';
import 'package:todo/utils/utils_string.dart';
import 'package:todo/widgets/my_widget_loading.dart';

import 'detail_page.dart';
import 'edit_menu_page.dart';
import 'setting_page.dart';

class RootPage extends StatefulWidget {
  final Tools tools;
  const RootPage({Key key, this.tools}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin{
  ScrollController scrollController;
  Color backgroundColor;
  LinearGradient backgroundGradient;
  Tween<Color> colorTween;
  Color constBackColor;
  DatabaseHelper _databaseHelper;
  StreamController _streamController = StreamController();
  List<MenuObject> _listMenus = [];
  set _menuObjectStream(List<MenuObject> list) {
    _listMenus = list;
    _streamController.sink.add(list);
  }
  get _menuObjectStream => _streamController.stream;
  int sumTask = 0;

  @override
  void initState() {
    super.initState();
    _databaseHelper = new DatabaseHelper();
    initListMenuObject();
    colorTween = ColorTween(begin: listMenus[0].theme.color, end: listMenus[0].theme.color);
    backgroundColor = listMenus[0].theme.color;
    backgroundGradient = listMenus[0].theme.getLinear;
    scrollController = ScrollController();
    scrollController.addListener(listener);
  }
  listener(){
    ScrollPosition position = scrollController.position;
    int page = position.pixels ~/ (position.maxScrollExtent / (_listMenus.length.toDouble() - 1));
    double pageDo = (position.pixels / (position.maxScrollExtent / (_listMenus.length.toDouble() - 1)));
    double percent = pageDo - page;
    if (_listMenus.length - 1 < page + 1) {
      return;
    }
    colorTween.begin = _listMenus[page].theme.color;
    colorTween.end = _listMenus[page + 1].theme.color;
    setState(() {
      backgroundColor = colorTween.transform(percent);
      backgroundGradient = _listMenus[page].theme.getLinear.lerpTo(_listMenus[page + 1].theme.getLinear, percent);
    });
  }
  initListMenuObject()async{
    sumTask = 0;
    List<MenuObject> list = await _databaseHelper.getListMenu(dayId: getDayId());
    for(MenuObject menuObject in list){
      sumTask += menuObject.tasks.length;
    }
    _menuObjectStream = list;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _streamController?.close();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(getTranslated(context, "appName")),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 26.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) => SettingsPage(
                        tools: widget.tools,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: Text(
                getTranslated(context, "welcome"),
                style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: Text(
                getTranslated(context, "YourJobToday"),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: Text(
                getTranslated(context, "YouHave") + sumTask.toString() + getTranslated(context, "tasksToDoToday"),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: getTranslated(context, "today"),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: rootDateFull(context: context, calendarId: widget.tools.calendarId, dateTime: new DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 20,
              child: _streamBuilder(),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: AnimatedFloatingActionButton(
              fabButtons: listMenus.map((MenuObject m){
                return Container(
                  child: FloatingActionButton(
                    onPressed: () => _selectMenuObject(menuObject: m),
                    heroTag: m.id,
                    elevation: 0.0,
                    tooltip: getTranslated(context, m.name),
                    child: Icon(m.theme.icon),
                    backgroundColor: m.theme.color,
                  ),
                );
              }).toList(),
              colorStartAnimation: Theme.of(context).primaryColor,
              colorEndAnimation: Theme.of(context).primaryColorDark,
              animatedIconData: AnimatedIcons.add_event //To principal button
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked ,
      ),
    );
  }
  Widget _streamBuilder(){
    return new StreamBuilder(
      stream: _menuObjectStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData){
          return new Container();
        }
        List<MenuObject> list = snapshot.data;
        if (list.length == 0){
          return new MyWidgetNull(color: Colors.white,);
        }
        return new ListView.builder(
          itemBuilder: (context, index) {
            MenuObject menu = list[index];

            return new MenuObjectCell(
              menu: menu,
              onShow: ()=> _selectMenuObject(menuObject: menu),
              onEditMenu: ()=> _editMenuObject(menuObject: menu),

            );
          },
          padding: EdgeInsets.only(left: 40.0, right: 40.0),
          scrollDirection: Axis.horizontal,
          physics: _CustomScrollPhysics(list),
          controller: scrollController,
          itemExtent: MediaQuery.of(context).size.width - 80,
          itemCount: list.length,
        );
      },
    );
  }


  _selectMenuObject({MenuObject menuObject}) async{
   await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
            DetailPage(menuObject: menuObject,isEdit: true,),
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
   initListMenuObject();

  }

  _editMenuObject({MenuObject menuObject}) async{
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
            EditMenuPage(menuObject: menuObject),
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
    initListMenuObject();

    print("EditMenu");

  }


}

class _CustomScrollPhysics extends ScrollPhysics {
  final List<MenuObject> list;
  _CustomScrollPhysics(this.list, {
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  _CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _CustomScrollPhysics(list,parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / (position.maxScrollExtent / (list.length.toDouble() - 1));
    // return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    // return page * position.viewportDimension;
    return page * (position.maxScrollExtent / (list.length.toDouble() - 1));
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }
}
