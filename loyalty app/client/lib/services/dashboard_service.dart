

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:loyalty_app/services/user_service.dart';
import 'package:http/http.dart' as http;
import '../models/dashbaord_model.dart';

class DashboardService{

  late DashboardModel dashboard;

  Future<DashboardModel> getDashboardData() async {
    try {
      final user = await UserService().getUser();
      String url =
          'https://loyality-app-backend.vercel.app/api/loyality/dashboard';

      print(user['data']);

      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': user['data'],
      });
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        dashboard = DashboardModel(
          full_name: data['response']['full_name'],
          loyalty_balance: (data['response']['loyalty_balance'] as num).toDouble(),
          loyalty_level: data['response']['loyalty_level'],
        );
        return dashboard;
      }
      else if(response.statusCode == 404){
        return DashboardModel(
          full_name: '',
          loyalty_balance: 0,
          loyalty_level: 0,
        );
      }
      else {
        return DashboardModel(
          full_name: '',
          loyalty_balance: 0,
          loyalty_level: 0,
        );
      }
    } catch (e) {
      kDebugMode ? print(e.toString()) : null;
      return DashboardModel(
        full_name: '',
        loyalty_balance: 0,
        loyalty_level: 0,
      );
    }
  }

}