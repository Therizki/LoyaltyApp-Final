import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  void storeUserSession(Map<String, dynamic> user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(user);
    await prefs.setString('user', jsonString);
  }

  Future<Map<String, dynamic>> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('user');
    if (jsonString != null) {
      Map<String, dynamic> user = json.decode(jsonString);
      return user;
    } else {
      throw Exception('user session does not exist');
    }
  }

  Future<bool> removeUserSession() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

}
