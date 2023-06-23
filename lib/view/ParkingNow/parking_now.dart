import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:park_spot/const/constants.dart';

class ParkingNow extends StatefulWidget {
  const ParkingNow({super.key});

  @override
  State<ParkingNow> createState() => _ParkingNowState();
}

class _ParkingNowState extends State<ParkingNow> {
  var text;
  String? city;
  String? slot;
  var data;
  bool isLoading = false;
  Future<String> getdata(Barcode barcode) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    text = await barcode.rawValue;
    data = jsonDecode(text);
    city = data['City'];
    slot = data['Slot'];
    print(data['City']);
    print(data['Slot']);
    setState(() {
      isLoading = false;
    });
    return text;
  }

  @override
  Widget build(BuildContext context) {
    String? textcode;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Mobile Scanner'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : MobileScanner(
                        allowDuplicates: false,
                        fit: BoxFit.fill,
                        controller: MobileScannerController(
                            facing: CameraFacing.back, torchEnabled: false),
                        onDetect: (barcode, args) {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            getdata(barcode);
                          }
                        }),
              ),
            ),
            Divider(),
            Text(("$city" == null) ? "" : "$city"),
            Text("$slot"),
          ],
        ));
  }
}
