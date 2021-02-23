import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../component/components.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registrationScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppBar(appbarID: id).appBar(),

      /// Registration Screen AppBar
      body: RegistrationBody(),

      /// Registration Screen Body
    );
  }
}

class RegistrationBody extends StatefulWidget {
  @override
  _RegistrationBodyState createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  /// Firebase Authentication Instance
  bool inSyncCall = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      ///  Loading Indicator shows when Button Pushed
      inAsyncCall: inSyncCall,
      child: Container(
        /// Whole Body is fitted in this Container
        color: Colors.black12,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoBox(
              /// App Logo Shows
              height: 200,
            ),
            InputTextFields(

                /// Text Fields Are Take user's input and Store value in variable
                onChangedEmail: (value) => email = value,
                onChangedPass: (value) => password = value),
            Buttons(onPressed: createNewUser).registerButton(),
            Divider(height: 20),
            Center(
              child: Text('OR'),
            ),

            ///
            /// Bellow Button is Google SignIn Button
            ///
            Buttons(onPressed: () async {
              setState(() {
                inSyncCall = true;
              });
              UserCredential creadential = await signInWithGoogle();

              if (creadential.user.email != null) {
                Navigator.pushNamed(
                  context,
                  ChatScreen.id,
                );
              }
              setState(() {
                inSyncCall = false;
              });
            }).googleSignIn(),
          ],
        ),
      ),
    );
  }

  /// following method is Create new user With Email And Password
  void createNewUser() async {
    setState(() {
      inSyncCall = true;
    });
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential != null
          ? Navigator.pushNamed(context, ChatScreen.id)
          : print('Usercraed NULL');
    } catch (e) {
      print(e);
    }
    setState(() {
      inSyncCall = false;
    });
  }

  /// following Method is SignIn with Google and return UserCredential
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    GoogleAuthCredential credential;
    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
