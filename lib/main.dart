import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            color: Colors.red,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: WelcomeScreen.id,
            routes: {
              ChatScreen.id: (context) => ChatScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              WelcomeScreen.id: (context) => WelcomeScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
            },
          );
        }
        return Container(
          color: Colors.lightBlueAccent,
        );
      },
    );
  }
}
