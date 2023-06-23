import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:park_spot/const/api_url.dart';
import 'package:park_spot/model/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletProvider extends ChangeNotifier {
  bool isLoadinggetamount = false;
  Wallet wallet = Wallet();

  Future<bool> getamount() async {
    isLoadinggetamount = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      http.Response response = await http.get(
        Uri.parse('$local/user/Get_Amount'),
        headers: {
          'Accept': 'application/json',
          'api_key': '123456789',
          'token': token!
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic data = await json.decode(response.body);
        wallet = Wallet.fromJson(data);
        isLoadinggetamount = false;
        notifyListeners();
        return true;
      } else {
        isLoadinggetamount = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoadinggetamount = false;
      notifyListeners();
      return false;
    }
  }
}
