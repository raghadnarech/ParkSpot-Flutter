import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/main.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/view/Auth/signup.dart';
import 'package:park_spot/view/home.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/widget/loading_page.dart';
import 'package:park_spot/widget/textinput_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _controllerPhoneNumber = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool? showlogin;
  LoginPage({super.key, this.showlogin});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    authProvider = Provider.of<AuthProvider>(context);

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
                    children: [
                      Container(
                        child: Image.asset(
                          "image/Login.png",
                          // height: height * 0.3,
                          width: width * 0.8,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextInputAuth(
                        hint: "Phone number ex:(9xx xxx xxx)",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: false,
                        type: TextInputType.number,
                        control: _controllerPhoneNumber,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextInputAuth(
                        hint: "Password",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: true,
                        type: TextInputType.text,
                        control: _controllerPassword,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forget Password?",
                            style: TextStyle(color: kPrimaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String text;

                            if (_globalKey.currentState!.validate()) {
                              if (_controllerPhoneNumber != "" &&
                                  _controllerPassword != "") {
                                text = await authProvider!.login(
                                    "0${_controllerPhoneNumber.text}",
                                    _controllerPassword.text);
                                if (text != '') {
                                  Flushbar(
                                    title: 'Login Feild',
                                    message: '$text',
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.red,
                                  ).show(context);
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: HomePage(),
                                        isIos: false,
                                        duration: Duration(milliseconds: 300),
                                      ));
                                  await prefs.setBool('isLogged', true);
                                }
                              }
                            }
                            ;
                          },
                          child: authProvider!.isLoadingLogin
                              ? CircularProgressIndicator(
                                  color: kBaseColor,
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "or  ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 129, 132)),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: SignupPage(),
                                      isIos: false,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ))
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
