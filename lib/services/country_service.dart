import 'dart:convert';
import 'package:devicelocale/devicelocale.dart';
import 'package:http/http.dart' as http;

import '../models/token.dart';
import 'database_service.dart';


class CountryService {
  static Future<String> getData() async {
    Token token = await DatabaseService.fetchTokens();

    http.Response response = await http.get(Uri.parse("https://geo.ipify.org/api/v2/country?apiKey=${token.locationToken}&ipAddress="));
    if (response.statusCode == 200) {
      Map<String, dynamic> locationx = jsonDecode(response.body);
      return locationx["location"]["country"];
    } else {
      String? locale = await Devicelocale.currentLocale;
      return locale == null ? 'GH' : locale.substring(locale.length - 2);
    }
  }
}
