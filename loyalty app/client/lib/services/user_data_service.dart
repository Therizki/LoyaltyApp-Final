// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../constant/const.dart';
// import '../models/user_data_model.dart';
//
// class UserDataService {
//   Future<UserData?> getUserData(String authToken) async {
//     final url = Uri.parse(GET_USER_DATA);
//
//     try {
//       final response = await http.get(
//         url,
//         headers: {"Authorization": authToken},
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         return UserData.fromJson(responseData['user']);
//       } else {
//         print("Error: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       // Handle exceptions
//       print("Exception: $e");
//       return null;
//     }
//   }
// }
