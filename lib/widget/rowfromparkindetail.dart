import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';

class RowDetailsParkingTimer extends StatelessWidget {
  String? title;
  String? text;

  RowDetailsParkingTimer({this.title, this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$text",
                  style: TextStyle(fontSize: 18, color: kBaseSecandryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
