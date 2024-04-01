// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../constant/const.dart';
// import '../models/login_response_model.dart';
//
// class AuthService {
//   Future<LoginResponse?> loginUser(String username, String password) async {
//     final url = Uri.parse(LOGIN_USER_API);
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "username": username,
//           "password": password,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         print("User Token: ");
//         print(responseData['data']);
//
//         //////// Save the user to sharedPreferences ////////////
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         // String userJsonString = response.body;
//         final responseDataa =
//             json.decode(response.body); // Parse the JSON response
//         final user = responseData['data']; // Extract the user object
//         // Save the user object in SharedPreferences.
//         prefs.setString('data', json.encode(responseData['data']));
//         //////////////////////
//         // print(responseData.toString());
//
//         // Store data in shared preferences
//         await storeUserDataInPreferences(responseData);
//
//         return LoginResponse.fromJson(responseData);
//       } else {
//         // Handle error, you might want to throw an exception or return null
//         print("Error: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       // Handle exceptions
//       print("Exception: $e");
//       return null;
//     }
//   }
//
//   Future<void> storeUserDataInPreferences(Map<String, dynamic> userData) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     // Store user data in shared preferences
//     prefs.setString('userToken', userData['data']);
//     // Add other data to store...
//
//     print("User data stored in preferences: $userData");
//   }
// }
