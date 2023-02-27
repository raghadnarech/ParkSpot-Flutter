import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/view/Auth/register.dart';
import 'package:pinput/pinput.dart';
import '../../const/constants.dart';
import '../../widget/textinput_auth.dart';

class OtpPage extends StatefulWidget {
  String? phone;
  OtpPage({super.key, @required this.phone});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: kBaseThirdyColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: kSecandryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: kBaseColor,
      ),
    );
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
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "image/OTP.png",
                        // height: height * 0.3,
                        width: width * 0.8,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "Please enter the OTP sent to your mobile number",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    SizedBox(
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        onCompleted: (pin) async {
                          try {
                            // FirebaseAuth.instance.setSettings(
                            //     appVerificationDisabledForTesting: true);
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode!,
                                        smsCode: pin))
                                .then((value) async {
                              if (value.user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                    (route) => true);
                              }
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't receive an OTP?  ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 129, 132),
                              fontSize: 13),
                        ),
                        GestureDetector(
                            onTap: () {
                              _verifyPhone();
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: kPrimaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    )),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    SizedBox(
                      height: height * 0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Edit Your Number",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  _verifyPhone() async {
    // FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+963${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential.smsCode);
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
