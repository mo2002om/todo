import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



Future<Directory> get getLocalPath async {
//  final directory = await getApplicationDocumentsDirectory();
  final directory = Platform.isAndroid
      ? await getApplicationDocumentsDirectory()
      : await getApplicationDocumentsDirectory();

  return directory;
}

