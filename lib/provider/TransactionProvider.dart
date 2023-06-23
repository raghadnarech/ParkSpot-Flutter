import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:park_spot/const/api_url.dart';
import 'package:park_spot/model/tansaction.dart';
import 'package:park_spot/model/type_cost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransactionProvider with ChangeNotifier {
  Transaction? transaction;
  bool isloadinggetTypeCost = false;
  bool isloadinggetTransactions = false;
  TypeCost typeCost = TypeCost();
  List<TypeCost> listTypeCost = [];

  List<Transaction> listtransactions = [];

  Future<bool> getMyTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.get(
      Uri.parse('$local/user/Get_Transaction_User'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
    );
    print(response.body);
    dynamic data = await json.decode(response.body);
    dynamic tr = data['data'];
    print(tr);
    if (response.statusCode == 200) {
      for (var element in tr) {
        transaction = Transaction.fromJson(element);
        listtransactions.add(transaction!);
        notifyListeners();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> getTypeCost() async {
    isloadinggetTypeCost = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse('$local/user/type_cost'),
        headers: {
          'Accept': 'application/json',
          'api_key': '123456789',
          'token': token!
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = await json.decode(response.body);
        for (var type in data['data']) {
          typeCost = TypeCost.fromJson(type);
          listTypeCost.add(typeCost);
          notifyListeners();
          print(type);
        }
        print(listTypeCost[0].cost);
        notifyListeners();
        isloadinggetTypeCost = false;
        notifyListeners();
      } else {
        isloadinggetTypeCost = false;

        notifyListeners();
      }
    } catch (e) {
      print(e);

      isloadinggetTypeCost = false;

      notifyListeners();
    }
  }
}
