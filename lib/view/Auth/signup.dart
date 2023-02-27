import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Auth/otp_page.dart';
import 'package:park_spot/view/Auth/register.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/widget/textinput_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

TextEditingController? _controllerPassword = TextEditingController();
final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class SignupPage extends StatelessWidget {
  bool? showlogin;

  SignupPage({super.key, this.showlogin});
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                          "image/Signup.png",
                          // height: height * 0.3,
                          width: width * 0.8,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Enter your phone number",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextInputAuth(
                        hint: "Phone number ex:(9xx xxx xxx)",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: false,
                        type: TextInputType.phone,
                        control: phoneController,
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              auth.setphone(phoneController.text);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Register(),
                                    isIos: false,
                                    duration: Duration(milliseconds: 300),
                                  ));
                            }
                            ;
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?  ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 129, 132)),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: LoginPage(),
                                      isIos: false,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              },
                              child: Text(
                                "Login",
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
