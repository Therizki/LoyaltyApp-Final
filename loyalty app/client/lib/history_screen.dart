import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/services/transaction_history_service.dart';
import 'package:loyalty_app/home_screen.dart';
import 'package:loyalty_app/reward_screen.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_app/services/user_service.dart';

import 'models/transaction_model.dart';



class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTransactions();
  }

  /*
  void getTransactions() async {
    transactionList = await TransactionHistoryService().getTransactions();
    for (var transaction in transactionList) {
      print('Transaction ID: ${transaction.id}');
      print('User ID: ${transaction.userId}');
      print('Item Name: ${transaction.itemName}');
      print('Price: ${transaction.price}');
      print('Transaction Date: ${transaction.transactionDate}');
      print('Version: ${transaction.v}');
      print('Full Name: ${transaction.fullName}');
      print('\n');
    }
  }

   */

  List<TransactionModel> transactionsList = [];

  Future<List<TransactionModel>> getTransactions() async {
    String url = 'https://loyality-app-backend.vercel.app/api/transaction/transaction-history';
    try{
      final user = await UserService().getUser();
      print(user['data']);

      final response = await http.get(Uri.parse(url), headers: {'Authorization' : user['data']});
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        transactionsList.clear();
        for(Map i in data['transactionHistory']){
          transactionsList.add(TransactionModel.fromJson(i));
        }
        return transactionsList;
      } else {
        kDebugMode ? print('error while fetching') : null;
      }
    }catch(e){
      kDebugMode ? print('from catch block'+e.toString()) : null;
    }
    return transactionsList;
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('d MMMM yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
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
                "assets/appbar_image.svg",
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
                    child: Icon(Icons.arrow_back)),
              ),
            ),

            // text box
            Positioned(
              top: 300,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(children: [
                    Text(
                      'History',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),

                    Expanded(
                        child: FutureBuilder(
                            future: getTransactions(),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                if(transactionsList.length == 0){
                                  return Center(
                                    child: Text('No any transaction yet'),
                                  );
                                }else{
                                  return ListView.builder(
                                      itemCount: transactionsList.length,
                                      itemBuilder: (context, index){
                                        String formattedDate = formatDate(snapshot.data![index].transactionDate.toString());
                                        return Container(
                                          margin: EdgeInsets.symmetric(vertical: 4), // Adjust margin as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4), // Adjust border radius as needed
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 0.2
                                            ),
                                          ),
                                          child: Card(
                                            elevation: 0, // Set Card elevation to 0 to avoid additional shadows
                                            child: ListTile(
                                              leading: Text("\$ "+snapshot.data![index].price.toString(),
                                                  style:
                                                  TextStyle(fontSize: 20, color: Colors.black)),
                                              title: Expanded(
                                                child: Text(snapshot.data![index].itemName.toString(),
                                                  style:
                                                  TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                                                  maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              subtitle: Text(formattedDate),
                                              trailing: Chip(
                                                label: Text("Completed",
                                                    style:
                                                    TextStyle(fontSize: 10, color: Colors.black)),
                                                color: MaterialStateColor.resolveWith(
                                                        (states) => Colors.green),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  );

                                }
                              }else{
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              }
                            }
                        )
                    ),
                  ]),
                ),
              ),
            ),
          ]),
    );
  }
}
