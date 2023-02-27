import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/splash.dart';
import 'package:provider/provider.dart';
import '../const/constants.dart';

class ButtonGridHome extends StatelessWidget {
  String? title;
  String? image;
  Widget? navigator;
  ButtonGridHome({this.image, this.title, this.navigator});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    mapProvider = Provider.of<MapProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () async {
        userProvider!.getallCar_user();
        mapProvider!.getallZone();
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: navigator!,
              isIos: false,
              duration: Duration(milliseconds: 300),
            ));
      },
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
