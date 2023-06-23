import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/view/Splash/splash.dart';

class WalletIcons extends StatelessWidget {
  const WalletIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 1),
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "image/wallet.png",
                      width: 35,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Wallet",
                      style: TextStyle(
                          color: kBaseColor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${walletProvider.wallet.amount} sp",
                      style: TextStyle(color: kBaseColor, fontSize: 12),
                    ),
                  ],
                )
              ],
            )));
  }
}
