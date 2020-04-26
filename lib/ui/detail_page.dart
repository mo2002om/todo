
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/models/helpers/database_helper.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/models/task_object.dart';
import 'package:todo/utils/build_theme_data.dart';
import 'package:todo/utils/local_notification.dart';
import 'package:todo/utils/utils_DateTime.dart';
import 'package:todo/utils/utils_colors.dart';
import 'package:todo/utils/utils_string.dart';
import 'package:todo/widgets/CustomCheckboxTile.dart';
import 'package:todo/widgets/modal_text_widgets.dart';
import 'package:todo/widgets/my_custom_widget.dart';
import 'package:todo/widgets/my_widget_loading.dart';

import '../app_localizations.dart';

class DetailPage extends StatefulWidget {
  final MenuObject menuObject;
  final bool isEdit;
  const DetailPage({Key key, this.menuObject,@required this.isEdit}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin  {

  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;
  MenuObject menu;
  final TextEditingController textEditingController = TextEditingController();

  DatabaseHelper _databaseHelper;
  LocalNotification _localNotification;

  StreamController _streamController = StreamController();
  set _taskObjectStream(List<TaskObject> list) {
    _streamController.sink.add(list);
  }
  get _taskObjectStream => _streamController.stream;
  TaskObject _taskObject;
  DateTime _dateTime;
  bool isDelete = false;

  TaskObject newTaskObject(){
    return new TaskObject(menuId: menu.id,dayId: getDayId(),title: "",done: 0,startDate: 0);
  }

  @override
  void initState() {
    menu = widget.menuObject;
    _dateTime = new DateTime.now();
    _taskObject = newTaskObject();
    scaleAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 1000), lowerBound: 0.0, upperBound: 1.0);
    percentComplete = menu.percentComplete();
    barPercent = percentComplete;
    animationBar = AnimationController(vsync: this, duration: Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          barPercent = animT.transform(animationBar.value);
        });
      });
    animT = Tween<double>(begin: percentComplete, end: percentComplete);
    scaleAnimation.forward();
    _databaseHelper = new DatabaseHelper();
    _localNotification = new LocalNotification();
    _localNotification.init();
    initListTaskObject();
    super.initState();
  }
  initListTaskObject()async{
    List<TaskObject> list = await _databaseHelper.getListTaskObjectWitMenuId(menuId: menu.id, dayId: getDayId());
    _taskObjectStream = list;
    setState(() {
      menu.tasks = list;
    });
    updateBarPercent();
  }

  @override
  void dispose() {
    super.dispose();
    animationBar.dispose();
    scaleAnimation.dispose();
    _streamController?.close();
  }

  void updateBarPercent() async {
    double newPercentComplete = menu.percentComplete();
    if (animationBar.status == AnimationStatus.forward || animationBar.status == AnimationStatus.completed) {
      animT.begin = newPercentComplete;
      await animationBar.reverse();
    } else {
      animT.end = newPercentComplete;
      await animationBar.forward();
    }
    percentComplete = newPercentComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: menu.id + "_background",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                        menu.tasks.length > 0 ? getIconText(
                          icon: Icon(
                            isDelete ? Icons.check : Icons.edit,
                            color: menu.style.color,
                          ),
                          text: isDelete ? getTranslated(context, "back") : getTranslated(context, "edit"),
                          onTap:() {
                            setState(() {
                              isDelete = !isDelete;
                            });
                          },
                        ) : new Container(),
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
                                  border: Border.all(color: Colors.grey.withAlpha(70), style: BorderStyle.solid, width: 1.0),
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
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 10.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Hero(
                        tag: menu.id + "_progress_bar",
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: barPercent,
                                  backgroundColor: Colors.grey.withAlpha(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(menu.style.color),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text((barPercent * 100).round().toString() + "%"),
                              )
                            ],
                          ),
                        ),
                      ),
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
                              child: _streamBuilder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.isEdit && !isDelete
                      ? Container(
                    height: 120,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        TextField(
                          controller: textEditingController,
                          onChanged: (String value){
                            setState(() {
                              _taskObject.title = value;
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
                                color: Colors.grey,
                              ),
                              prefixIcon: GestureDetector(
                                onTap:() {

                                },
                                child: Icon(
                                  menu.icon,
                                  color: menu.style.color,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  if(completed()){
                                    _addTaskObject();
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: completed()
                                          ? menu.style.color
                                          : Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: completed()
                                        ? Colors.black
                                        : menu.style.color,
                                    size: 20,
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              getIconText(
                                icon: Icon(
                                  Icons.timer,
                                  color: menu.style.color,
                                ),
                                text: _taskObject.startDate == 0 ? getTranslated(context, "startingTime") : getMissionTime(timestamp: _taskObject.startDate),
                                onTap:() async{
                                  _dateTime = new DateTime.now();
                                  final selectedTime = await selectTime(context: context,dateTime: _dateTime);
                                  if (selectedTime == null) return;
                                  _dateTime = DateTime(
                                    _dateTime.year,
                                    _dateTime.month,
                                    _dateTime.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );
                                  setState(() {
                                    _taskObject.startDate = _dateTime.millisecondsSinceEpoch;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      : new Container(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _streamBuilder(){
    return new StreamBuilder(
      stream: _taskObjectStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData){
          return new Container();
        }
        List<TaskObject> list = snapshot.data;
        if (list.length == 0){
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: new MyWidgetNull(),
          );
        }
        return new ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemBuilder: (BuildContext context, int index) {
            TaskObject task = list[index];
            return rootCell(task);
          },
          itemCount: list.length,
        );
      },
    );
  }

  Widget rootCell(TaskObject task){
    switch(isDelete){
      case false:
        return new CustomCheckboxListTile(
          activeColor: menu.style.color,
          value: task.isCompleted,
          onChanged: (value) {
            _updateTaskObject(task: task);
          },
          title: Text(task.title),
          secondary: Icon(Icons.alarm),
          subtitle: Text(getMissionTime(timestamp: task.startDate)),
        );
        break;
      case true:
        return new Row(
          children: <Widget>[
            new IconButton(icon: new Icon(Icons.delete), onPressed: ()=> _deleteTaskObject(task: task)),
            new Expanded(
                child: new Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(task.title),
                        new Text(getMissionTime(timestamp: task.startDate)),
                      ],
                    ),
                  ),
                ),
            )
          ],
        );
        break;
      default:
        return new CustomCheckboxListTile(
          activeColor: menu.style.color,
          value: task.isCompleted,
          onChanged: (value) {
            _updateTaskObject(task: task);
          },
          title: Text(task.title),
          secondary: Icon(Icons.alarm),
          subtitle: Text(getMissionTime(timestamp: task.startDate)),
        );
    }
  }

  _addTaskObject()async{
    FocusScope.of(context).requestFocus(new FocusNode());
    TaskObject taskObject = _taskObject;
    await _databaseHelper.insert(taskObject);
    Push push = new Push(id: taskObject.pushId,title: appName,subtitle: taskObject.title,dateTime: _dateTime);
    _localNotification.showNotificationsAfter(push: push);
    _taskObject = newTaskObject();
    textEditingController.text = "";
    _dateTime = new DateTime.now();
    initListTaskObject();
  }

  _updateTaskObject({TaskObject task})async{
    TaskObject taskObject = task;
    taskObject.done = task.done == 0 ? 1 : 0;
    if(taskObject.done == 1){
      _localNotification.notificationCancel(id: taskObject.pushId);
    }
    await _databaseHelper.update(taskObject);
    initListTaskObject();
  }

  _deleteTaskObject({TaskObject task})async{
    await _databaseHelper.delete(task);
    _localNotification.notificationCancel(id: task.pushId);
    initListTaskObject();

  }


  bool completed(){
    if(_taskObject.title.length < 5 || _taskObject.startDate == 0 ){
      return false;
    }
    return true;
  }


}
