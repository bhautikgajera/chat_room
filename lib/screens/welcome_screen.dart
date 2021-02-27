import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../component/components.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar(appbarID: WelcomeScreen.id).appBar(),
      body: WelcomeScreenBody(),
    );
  }
}

class WelcomeScreenBody extends StatefulWidget {
  @override
  _WelcomeScreenBodyState createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody>
    with SingleTickerProviderStateMixin {
  bool inSyncCall = false;
  AnimationController controller;
  AnimationController controllerText;
  double textAnimationValue;
  double mainContainerColor;
  AnimationStatus animationStatus;

  @override
  void initState() {
    animation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      /// loading indicator show when button pressed
      inAsyncCall: inSyncCall,
      child: Container(
        color: Colors.black12.withOpacity(mainContainerColor ?? 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                /// This row Shows App's Logo and text
                children: [
                  LogoBox(
                      height: animationStatus != AnimationStatus.dismissed
                          ? (mainContainerColor ?? 1) * 100
                          : 50),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'ChatRoom',
                      style: TextStyle(fontSize: textAnimationValue),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'You can register or Login your self',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            /// Log in Button push screen to Login Screen
            Buttons(onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            }).loginButton(),

            /// Register Button Push Screen to Registration Screen

            Buttons(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ).registerButton(),
          ],
        ),
      ),
    );
  }

  void animation() {
    controller = AnimationController(
      lowerBound: 0.2,
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
    );
    controller.forward();

    controller.addListener(() {
      setState(() {
        mainContainerColor = controller.value;
      });
    });

    controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();

          controller.addListener(() {
            setState(() {
              mainContainerColor = controller.value;
            });
          });
        }
      },
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (status == AnimationStatus.dismissed) {
          animationStatus = status;
        }
      }
    });
  }
}
