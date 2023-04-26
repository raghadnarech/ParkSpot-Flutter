import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Auth/otp_page.dart';
import 'package:park_spot/view/home.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/widget/textinput_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Register_Car extends StatefulWidget {
  bool? showlogin;
  Register_Car({super.key, this.showlogin});

  @override
  State<Register_Car> createState() => _Register_CarState();
}

TextEditingController typeController = TextEditingController();
TextEditingController colorController = TextEditingController();
TextEditingController countryController = TextEditingController();

class _Register_CarState extends State<Register_Car> {
  TextEditingController _vehicleIDController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String TypeSelect = "KIA";
  List<String> Type = [
    "BMW",
    "KIA",
  ];
  String ColorSelect = "White";
  List<String> colors = [
    "White",
    "Red",
  ];
  String CountrySelect = "Damascus";
  List<String> Country = [
    "Damascus",
    "Homs",
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UserProvider auth = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "image/board3.png",
                              // height: height * 0.3,
                              width: width * 0.8,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Select Your Type Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: TypeSelect,
                            items: Type.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                )).toList(),
                            onChanged: (String? item) => setState(() {
                                  TypeSelect = item!;
                                  print(TypeSelect);
                                })),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Select Your Color Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: ColorSelect,
                            items: colors
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (String? item) => setState(() {
                                  ColorSelect = item!;
                                })),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Select Country Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: CountrySelect,
                            items:
                                Country.map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    )).toList(),
                            onChanged: (String? item) => setState(() {
                                  CountrySelect = item!;
                                  print(CountrySelect);
                                })),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        "Enter Your Vehicle ID:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextInputAuth(
                        hint: "Vehicle ID",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: false,
                        type: TextInputType.number,
                        control: _vehicleIDController,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: () async {
                            String text;
                            if (_globalKey.currentState!.validate()) {
                              text = await auth.register_car(
                                  CountrySelect,
                                  _vehicleIDController.text,
                                  TypeSelect,
                                  ColorSelect);
                              if (text != '') {
                                Flushbar(
                                  backgroundColor: Colors.red,
                                  title: 'Failed',
                                  message: '$text',
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: HomePage(),
                                      isIos: false,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              }
                            }
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
