import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/const.dart';
import '../models/register_model.dart';

class SignUpService {
  // ; // Replace with your actual URL

  Future<int> signUp(SignUpRequest signUpRequest) async {
    final url = Uri.parse(
        "https://loyality-app-backend.vercel.app/api/auth/register"); // Replace "signup" with your actual signup endpoint

    print("Json Data\n " + signUpRequest.toJson().toString());
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(signUpRequest.toJson()),
      );

      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful!');
        print('Response: ${response.body}');
        // go to Login Screen

        print('Request failed with status code: ${response.statusCode}');
        return response.statusCode;
      } else {
        return 0;
      }
    } catch (e) {
      // print(response.statusCode);
      print('Error: $e');
      return 0;
    }
  }
}
