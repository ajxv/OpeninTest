import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';

class ApiServices {
  Future<DashboardData> getDashboardData() async {
    // api access token stored in .env file for the time being
    // can be stored in secureStorage later once app has more modules
    // load .env file
    await dotenv.load(fileName: 'lib/services/.env');

    var accessToken = dotenv.env['ACCESS_TOKEN'];
    Uri url = Uri.parse(dotenv.env['API_ENDPOINT']!);

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        return DashboardData.fromJson(jsonDecode(response.body));
      } else {
        return Future.error("Failed to load DashboardData");
      }
    } on SocketException {
      return Future.error("SocketException: Check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
