import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/view/home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    _navigatetohome();
    super.initState();
  }

  _navigatetohome() async {
    await Future.delayed(
        Duration(seconds: 3),
        () async => {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: HomePage(),
                    isIos: false,
                    duration: Duration(milliseconds: 300),
                  ))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      ),
    );
  }
}
