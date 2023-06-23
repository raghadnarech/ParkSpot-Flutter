import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/view/Car/select_car.dart';

class SelectVehiacleCard extends StatelessWidget {
  const SelectVehiacleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Vehiacle",
          style: TextStyle(
            color: kBaseSecandryColor,
            fontSize: 18,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: SelectCar(),
                  isIos: false,
                  duration: Duration(milliseconds: 300),
                ));
          },
          child: Text(
            "Change",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
