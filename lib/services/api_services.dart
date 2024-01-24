import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';

class ApiServices {
  Future<DashboardData> getDashboardData() async {
    var accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI';

    Uri url = Uri.parse("https://api.inopenapp.com/api/v1/dashboardNew");

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
