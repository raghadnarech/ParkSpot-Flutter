import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:provider/provider.dart';
import '../const/constants.dart';

class ListTileDrawer extends StatelessWidget {
  String? title;
  String? subtitle;
  IconData? icon;
  Widget? navigator;
  ListTileDrawer({this.title, this.subtitle, this.icon, this.navigator});

  @override
  Widget build(BuildContext context) {
    carProvider = Provider.of<CarProvider>(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: kPrimaryColor, size: 30),
      title: Text("$title"),
      subtitle: Text("$subtitle", style: TextStyle(fontSize: 10)),
      onTap: () async {
        title == "My vehicle" ? carProvider.getallCar_user() : null;
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: navigator!,
              isIos: false,
              duration: Duration(milliseconds: 300),
            ));
      },
    );
  }
}
