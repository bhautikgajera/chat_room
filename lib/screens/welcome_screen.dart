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

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
  bool inSyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      /// loading indicator show when button pressed
      inAsyncCall: inSyncCall,
      child: Container(
        color: Colors.black12,
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
                    height: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ChatRoom',
                    style: TextStyle(fontSize: 30),
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
}
