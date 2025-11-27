import 'dart:convert';

import 'package:azkar_app_rehi/models/azkar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History {
  Future<List<AzkarModel>> getHistory() async {
    final sp = await SharedPreferences.getInstance();
    final data = sp.getStringList("history") ?? [];
    return data
        .map((e) => AzkarModel.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future saveHistory(AzkarModel azkar) async {
    final sp = await SharedPreferences.getInstance();
    var data = await getHistory();
    data.insert(0, azkar);
    var encoded = data.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList("history", encoded);
  }

  Future deleteHistory(int index) async {
    final sp = await SharedPreferences.getInstance();
    var data = await getHistory();
    data.removeAt(index);
    var encoded = data.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList("history", encoded);
  }
}
