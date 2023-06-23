import 'package:flutter/cupertino.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/view/Splash/splash.dart';

class CardCarPreview extends StatelessWidget {
  const CardCarPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${carProvider.CarList[carProvider.defaultcar].Type}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${carProvider.CarList[carProvider.defaultcar].Country}"
                  " | "
                  "${carProvider.CarList[carProvider.defaultcar].NumCar}",
                  style: TextStyle(fontSize: 18, color: kBaseSecandryColor),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "image/carlogo/car.png",
                  width: 120,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
