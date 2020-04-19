
import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/cells/menu_object_cell.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/models/tools.dart';
import 'package:intl/intl.dart';

import 'setting_page.dart';

class RootPage extends StatefulWidget {
  final Tools tools;
  const RootPage({Key key, this.tools}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin{
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      ScrollPosition position = scrollController.position;
      int page = position.pixels ~/ (position.maxScrollExtent / (listMenus.length.toDouble() - 1));
      double pageDo = (position.pixels / (position.maxScrollExtent / (listMenus.length.toDouble() - 1)));
      double percent = pageDo - page;
      if (listMenus.length - 1 < page + 1) {
        return;
      }
      print("page == $page");
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepOrange , Colors.amber], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(getTranslated(context, "appName")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.language,
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
                "Hello, John.",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: Text(
                "الأعمال اليومية",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: Text(
                "لديك 10 مهام للقيام بها اليوم.",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0,right: 50.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "TODAY : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat.yMMMMd().format(DateTime.now()),
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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  MenuObject menu = listMenus[index];
                  return new MenuObjectCell(menu: menu,);
                },
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                scrollDirection: Axis.horizontal,
                physics: _CustomScrollPhysics(),
                controller: scrollController,
                itemExtent: _width - 80,
                itemCount: listMenus.length,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

}

class _CustomScrollPhysics extends ScrollPhysics {
  _CustomScrollPhysics({
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  _CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _CustomScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / (position.maxScrollExtent / (listMenus.length.toDouble() - 1));
    // return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    // return page * position.viewportDimension;
    return page * (position.maxScrollExtent / (listMenus.length.toDouble() - 1));
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
