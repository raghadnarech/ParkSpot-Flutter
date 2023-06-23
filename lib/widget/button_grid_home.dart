import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:provider/provider.dart';
import '../const/constants.dart';

class ButtonGridHome extends StatelessWidget {
  String? title;
  String? image;
  Function()? onTap;
  ButtonGridHome({this.image, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    mapProvider = Provider.of<MapProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      strokeAlign: StrokeAlign.outside,
                      width: 2,
                      color: kBaseThirdyColor,
                    )),
                child: Image.asset(
                  "$image",
                )),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "$title",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
