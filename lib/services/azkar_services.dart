import 'dart:convert';

import 'package:azkar_app_rehi/models/azkar_model.dart';
import 'package:http/http.dart' as http;

Future<List<AzkarModel>> fitchAzkars() async {
  try {
    final response = await http.get(
      Uri.parse("https://ahegazy.github.io/muslimKit/json/azkar_sabah.json"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // print(data["content"]);
      final convertedData = (data["content"]) as List;
      return convertedData
          .map(
            (e) => AzkarModel(
              content: e["zekr"],
              description: e['bless'],
              count: e['repeat'],
              currentCount: 0,
            ),
          )
          .toList();
    } else {
      throw Exception("Error Happened");
    }
  } catch (e) {
    throw Exception(e);
  }
}
