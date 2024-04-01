// import 'package:flutter/material.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Home Screen',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Roboto',
//               )),
//
//           SizedBox(
//             height: 50,
//           ),
//
//           // elevated button to navigate to the login screen
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     ));
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/services/dashboard_service.dart';
import 'package:loyalty_app/services/user_service.dart';
import 'package:toastification/toastification.dart';
import 'models/dashbaord_model.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {

  late Timer _timer;
  @override
  void initState() {
    super.initState();

    /*
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        print('Running code in timers setstate');
      });
    });

     */
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              "assets/home_page_topbar.svg",
              // height: 400,
              // width: 400,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ),
          ),

          // text box
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("My Points",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: DashboardService().getDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.loyalty_balance == 0){
                          return CustomPaint(
                            foregroundPainter: CircleProgress(0),
                            child: Container(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: Text(
                                  'No loyalty points yet',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }else{
                          return CustomPaint(
                            foregroundPainter: CircleProgress(43),
                            child: Container(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: Text(
                                  snapshot.data!.loyalty_balance.toString(),
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }

                      } else {
                        return CustomPaint(
                          foregroundPainter: CircleProgress(0),
                          child: Container(
                            width: 200,
                            height: 200,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('150 OFF \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 100P',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('150 OFF \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 100P',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('150 OFF \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 100P',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text('150 OFF \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 100P',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                ],
              ),
            ),
          ),
        ]));
  }
}

class CircleProgress extends CustomPainter {
  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc); // this draws the progress circle
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
