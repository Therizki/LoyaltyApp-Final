import 'package:flutter/material.dart';
import 'package:loyalty_app/home_screen.dart';
import 'package:loyalty_app/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Service/register_service.dart';
import 'models/register_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isSignUp = false;

  Future<void> _signUp() async {
    final String fullName = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();
    final String phoneNumber = _phoneController.text.trim();

    setState(() {
      isSignUp = true;
    });
    if (password != confirmPassword) {
      setState(() {
        isSignUp = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
      return;
    }

    final signUpRequest = SignUpRequest(
      fullName: fullName,
      email: email,
      password: password,
    );

    SignUpService signUpService = SignUpService();

    try {
      int isRegister = await signUpService.signUp(signUpRequest);
      // Handle navigation or other UI updates upon successful signup

      if (isRegister == 200) {
        setState(() {
          isSignUp = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Account has been created Successfully, Please LogIn'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );


        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } else {
        setState(() {
          isSignUp = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Email already exists'),
              content: Text('Please try again with a different email.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        isSignUp = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBECFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset('assets/welcome_page_image.png',
                      width: 50, height: 50),
                ),
                SizedBox(height: 30),
                Text("Create your account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'ex: Jon Smith',
                      ),
                    ),
                    SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'ex: jon.smith@email.com',
                      ),
                    ),
                    SizedBox(height: 20),
                    // const Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: Text("Phone",
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.normal,
                    //           fontFamily: 'Roboto',
                    //         )),
                    //   ),
                    // ),
                    // TextFormField(
                    //   controller: _phoneController,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //       borderSide: BorderSide(
                    //         color: Colors.white,
                    //         width: 1.0,
                    //       ),
                    //     ),
                    //     hintText: '924729876789',
                    //   ),
                    //   obscureText: false,
                    // ),
                    // SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        hintText: '*********',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Confirm Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            )),
                      ),
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        hintText: '*********',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF094EFF),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _signUp,
                        child: isSignUp ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ) : Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF094EFF),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SignUpRequest {
//   final String fullName;
//   final String email;
//   final String password;
//
//   SignUpRequest({
//     required this.fullName,
//     required this.email,
//     required this.password,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'full_name': fullName,
//       'email': email,
//       'password': password,
//     };
//   }
// }

// class SignUpService {
//   static const String baseUrl = 'http://your-api-url.com'; // Replace with your actual URL
//
//   Future<void> signUp(SignUpRequest signUpRequest) async {
//     final String signUpEndpoint = '$baseUrl/SIGN_UP';
//
//     try {
//       final response = await http.post(
//         Uri.parse(signUpEndpoint),
//         body: jsonEncode(signUpRequest.toJson()),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         print('Request successful!');
//         print('Response: ${response.body}');
//         // Handle the response here
//       } else {
//         print('Request failed with status code: ${response.statusCode}');
//         throw Exception('Failed to sign up');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to sign up');
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:loyalty_app/login_screen.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEBECFF),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 32, right: 32),
//           child: SingleChildScrollView(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 100,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     // change boarder color
//                     border: Border.all(
//                       color: Colors.blue,
//                       width: 2.0,
//                     ),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: const EdgeInsets.all(5),
//                   // color: Colors.white,
//                   child: Image.asset('assets/welcome_page_image.png',
//                       width: 50, height: 50),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Text("Create your account",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Roboto',
//                     )),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text("Name",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'Roboto',
//                             )),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         hintText: 'ex: jon smith',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text("Email",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'Roboto',
//                             )),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         hintText: 'ex: jon.smith@email.com',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text("Password",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'Roboto',
//                             )),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         hintText: '*********',
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text("Confirm Password",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'Roboto',
//                             )),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1.0,
//                           ),
//                         ),
//                         hintText: '*********',
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: Color(0xFF094EFF), // background
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 100),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) => LoginScreen()),
//                           // );
//                         },
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                             fontFamily: 'Roboto',
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // don't have an account login
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Already have an account?",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                               fontFamily: 'Roboto',
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LoginScreen()),
//                               );
//                             },
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(
//                                 color: Color(0xFF094EFF),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
