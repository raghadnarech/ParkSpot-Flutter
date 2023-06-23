import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';

import 'package:park_spot/view/Auth/Login.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBaseColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
                // print(isLastPage);
              });
            },
            children: [
              OnboardContent(
                image: "image/board3.png",
                description:
                    "Search parking space near your location, per book your parking spaces and pay via online mode.",
                title: "Explore Nearby Parking Spaces & Pay Online",
              ),
              OnboardContent(
                image: "image/board2.png",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,",
                title: "Lorem ipsum dolor sit amet",
              ),
              OnboardContent(
                image: "image/board1.png",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,",
                title: "Lorem ipsum dolor sit amet",
              ),
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              color: kBaseColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: height * 0.1,
              child: Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        foregroundColor: kPrimaryColor,
                        backgroundColor: kBaseColor,
                        minimumSize: Size.fromHeight(20)),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('showlogin', true);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 24),
                    )),
              ),
            )
          : Container(
              color: kBaseColor,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(kBaseSecandryColor),
                    ),
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  SmoothPageIndicator(
                    onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    controller: controller,
                    count: 3,
                    effect: WormEffect(
                        spacing: 16,
                        dotHeight: 4,
                        dotColor: kBaseSecandryColor,
                        activeDotColor: kPrimaryColor),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(kBaseSecandryColor),
                    ),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  OnboardContent({this.image, this.title, this.description});
  String? image, title, description;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Image.asset(
            fit: BoxFit.cover,
            image!,
            // height: height * 0.6,
          ),
          Spacer(),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          Spacer(),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
