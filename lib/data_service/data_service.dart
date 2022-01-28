import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:earthquake_app/model/quake_model.dart';


class DataService {
  Future<QuakeModel> getInfo() async {
    var api =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";
    final http.Response response = await http.get(Uri.parse(api));
    try {
      if (response.statusCode == 200) {
        return QuakeModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('error2');
    }
  }
}
