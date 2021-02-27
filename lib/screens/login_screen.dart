import 'package:chat_room/component/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'chat_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// this is Login Screen AppBar it's Come from Custom Created Class
      appBar: ScaffoldAppBar(appbarID: LoginScreen.id).appBar(),

      /// this is Login Screen Body>>  object is declared bellow
      body: LoginScreenBody(),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  String email;

  String password;

  bool inSyncCall = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(doesUserSignOut());
    return ModalProgressHUD(
      /// Loading Indicator Show When Button Pressed
      inAsyncCall: inSyncCall,
      child: Container(
        /// Container Contain Whole Body of Screen
        color: Colors.black12,
        child: ListView(
          children: [
            LogoBox(
              height: 200,
            ),
            InputTextFields(
              /// Text Fields Are Take  Input And Store Value In Variable
              onChangedEmail: (value) => email = value,
              onChangedPass: (value) => password = value,
            ),

            /// User Login Button Login With Email And Password <<userLogin>> method is declared bellow
            /// When Button Pressed Screen Goes to ChatScreen
            Buttons(onPressed: userLogin).loginButton(),

            Divider(height: 20),
            Center(
              child: Text('OR'),
            ),

            /// this is Google SignIn Button When Button Pressed and
            /// User verification done Screen Goes to ChatScreen
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
            }).googleSignIn()
          ],
        ),
      ),
    );
  }

  /// declaration of << userLogIn >> method
  void userLogin() async {
    setState(() {
      inSyncCall = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userCredential != null
          ? Navigator.pushNamed(context, ChatScreen.id)
          : print('userCred null');
    } catch (e) {
      print(e);
    }
    setState(() {
      inSyncCall = false;
    });
  }

  /// Declaration of << signInWithGoogle >> method
  /// this method return UserCredential when It's get Called
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

  bool doesUserSignOut() {
    bool userState = false;
    userState = _auth.currentUser == null ?? true;
    return userState;
  }
}
