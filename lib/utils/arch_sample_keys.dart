
import 'package:flutter/widgets.dart';

class ArchSampleKeys {

  static final keyChartWeek = const Key('__keyChartWeek__');
  static final keyHomePage = const Key('__HomePage__');

  static final keyMissionCell = (String id) => Key('Mission_${id}__Cell');

  static final keyBestFile = (String id) => Key('StoryTemplate_${id}__Cell');
  static final keyImage = (String id) => Key('Image_${id}__url');

  //PhotoFilter
  static final keyFilter = (String id) => Key('Filter_${id}__url');

}
