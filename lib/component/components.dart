import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import '../constents.dart';
import '../screens/chat_screen.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../screens/welcome_screen.dart';

/// This  Components can be use in App to implement some features in the App

/// RoundedButton is a Button Skeleton widget Of the Login And Register Button
/// it's take Arguments as Color(Color),buttonText(String),onPressed(Function)And googleButton(bool)
/// and create a Button Widget according to it's given Argument
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.color,
    this.buttonText,
    this.onPressed,
    this.googleButton,
    Key key,
  }) : super(key: key);

  final Color color;
  final buttonText;
  final Function onPressed;
  final bool googleButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: !googleButton
          ? Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: color,
              child: MaterialButton(
                onPressed: onPressed,
                minWidth: 250.0,
                child: Text(buttonText),
              ),
            )
          : SignInButton(
              buttonType: ButtonType.google,
              onPressed: onPressed,
              buttonSize: ButtonSize.medium,
            ),
    );
  }
}

/// this is Button Class
/// this class have a different methods for different Types of Button
/// Each method returns Rounded Button According to given attributes
/// like loginButton RegisterButton and Google SignIn Button
class Buttons {
  final Function onPressed;

  Buttons({this.onPressed});

  /// Login Button for All Screens  ///
  RoundedButton loginButton() {
    return RoundedButton(
      color: Colors.lightBlueAccent,
      buttonText: 'Login',
      onPressed: onPressed,
      googleButton: false,
    );
  }

  RoundedButton registerButton() {
    return RoundedButton(
      buttonText: 'Register',
      color: Colors.lightBlue,
      onPressed: onPressed,
      googleButton: false,
    );
  }

  RoundedButton googleSignIn() {
    return RoundedButton(
      googleButton: true,
      color: Colors.blue,
      buttonText: 'SignIn With Google',
      onPressed: onPressed,
    );
  }
}

/// this is a ScaffoldAppBar Class
/// this class contain different AppBar for different Screen
class ScaffoldAppBar {
  final String appbarID;
  ScaffoldAppBar({@required this.appbarID});

  AppBar appBar({Function onPressed}) {
    if (appbarID == WelcomeScreen.id) {
      return AppBar(
        title: Text('Welcome to ChatRoom'),
      );
    }

    if (appbarID == LoginScreen.id) {
      return AppBar(
        title: Text('ChatRoom Login'),
      );
    }
    if (appbarID == RegistrationScreen.id) {
      return AppBar(
        title: Text('ChatRoom  Register'),
      );
    }
    if (appbarID == ChatScreen.id) {
      return AppBar(
        actions: [FlatButton(onPressed: onPressed, child: Text('SignOut'))],
        title: Text('ChatRoom ChatField'),
      );
    }
    return AppBar(
      title: Text('ChatRoom'),
    );
  }
}

/// this is InputTextFields class or Widget
/// the class contain Two TextField Widgets
/// TextFields are used for take input from the user and Store value to the variable
class InputTextFields extends StatelessWidget {
  final onChangedEmail;
  final onChangedPass;
  InputTextFields(
      {@required this.onChangedEmail, @required this.onChangedPass});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
              onChanged: onChangedEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Your Password'),
              onChanged: onChangedPass,
            ),
          ),
        ],
      ),
    );
  }
}

/// this is the LogoBox Widget
/// it's contain logo(Image from assets)
/// the image is a child of it's parent Widget Container
/// the container it's self child of hero widget
/// the Hero Widget is responsible for animate logo in Different Screens
class LogoBox extends StatelessWidget {
  final double height;
  LogoBox({this.height});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Container(
        margin: EdgeInsets.all(20),
        height: height,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
