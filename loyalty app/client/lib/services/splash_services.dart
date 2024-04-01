
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/home_screen.dart';
import 'package:loyalty_app/login_screen.dart';
import 'package:loyalty_app/services/user_service.dart';

class SplashServices {

  // Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async{
    UserService().getUser().then((value) async{
        await Future.delayed(Duration(seconds: 3));
        // Navigator.pushNamed(context, RoutesName.login);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, stackTrace) async{
      if(kDebugMode){
        print(error.toString());
      }
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

}