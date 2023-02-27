import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';

import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/view/Auth/register_car.dart';

import 'package:park_spot/widget/textinput_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _repasswordController = TextEditingController();
final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class Register extends StatefulWidget {
  bool? showlogin;

  Register({super.key, this.showlogin});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    bool isLoading = false;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "image/Signup.png",
                              // height: height * 0.3,
                              width: width * 0.8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Your phone number:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                          width: double.infinity,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xffececec),
                          ),
                          child:
                              Center(child: Text("+963${auth.phonenumber}"))),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Enter Your Name:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextInputAuth(
                        hint: "Name",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: false,
                        type: TextInputType.text,
                        control: _nameController,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Enter Your Password:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextInputAuth(
                        hint: "Password",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: true,
                        type: TextInputType.text,
                        control: _passwordController,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Confirm Your Password:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextInputAuth(
                        hint: "re-Password",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: true,
                        type: TextInputType.text,
                        control: _repasswordController,
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
                            if (_globalKey.currentState!.validate()) {
                              if (_passwordController.text !=
                                  _repasswordController.text) {
                                Flushbar(
                                  title: 'Password',
                                  message: 'Please Check your Password',
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                await auth.register(
                                    _nameController.text,
                                    "0${auth.phonenumber}",
                                    _passwordController.text);

                                _nameController.text = "";
                                _passwordController.text = "";
                                _repasswordController.text = "";

                                Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Register_Car(),
                                      isIos: false,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              }
                            }
                          },
                          child: auth.isLoading
                              ? CircularProgressIndicator(
                                  color: kBaseColor,
                                )
                              : Text(
                                  "Next",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
