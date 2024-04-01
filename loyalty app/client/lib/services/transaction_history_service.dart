//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:loyalty_app/model/transaction_model.dart';
// import 'package:http/http.dart' as http;
//
// class TransactionHistoryService{
//
//   String url = 'https://loyality-app-backend.vercel.app/api/transaction/transaction-history';
//
//   List<TransactionModel> transactionsList = [];
//
//   /*
//   void getTransactions() async {
//     try{
//       final response = await http.get(Uri.parse(url), headers: {'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZjIyZmY5MDM2ZTE3MmRhNjJmZmU4ZCIsInVzZXJuYW1lIjoic2FqaWRiaGF0dGlAZ21haWwuY29tIiwiaWF0IjoxNzEwMzcwOTM1fQ.yPZuPzoRfiE5C2hgrQefA74jAzaG8uzrPnfvzyS3wo0'});
//       var data = jsonDecode(response.body.toString());
//       if (response.statusCode == 200) {
//         transactionsList.clear();
//         for(Map i in data['transactionHistory']){
//           transactionsList.add(TransactionModel.fromJson(i));
//         }
//         // print(transactionsList[0].toString());
//       } else {
//         print('Error while api');
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//    */
//
//   Future<List<TransactionModel>> getTransactions() async {
//     try{
//       final response = await http.get(Uri.parse(url), headers: {'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZjIyZmY5MDM2ZTE3MmRhNjJmZmU4ZCIsInVzZXJuYW1lIjoic2FqaWRiaGF0dGlAZ21haWwuY29tIiwiaWF0IjoxNzEwMzcwOTM1fQ.yPZuPzoRfiE5C2hgrQefA74jAzaG8uzrPnfvzyS3wo0'});
//       var data = jsonDecode(response.body.toString());
//       if (response.statusCode == 200) {
//         transactionsList.clear();
//         for(Map i in data['transactionHistory']){
//           transactionsList.add(TransactionModel.fromJson(i));
//         }
//         // print(transactionsList[0].toString());
//         return transactionsList;
//       } else {
//         kDebugMode ? print('error while fetching') : null;
//       }
//     }catch(e){
//       kDebugMode ? print('from catch block'+e.toString()) : null;
//     }
//     return transactionsList;
//   }
// }