import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void save(String aa) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final downloadList = preferences.getStringList('key') ?? [];
  downloadList.add(aa);
  preferences.setStringList('key', downloadList);
  for (var i = 0; i < downloadList.length; i++) {
    print(json.decode(downloadList[i]));
  }
}
