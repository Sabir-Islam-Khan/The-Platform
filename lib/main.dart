import 'package:flutter/material.dart';
import 'package:the_platform/Services/LandingPage.dart';
import 'package:the_platform/Services/MyAuth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(ThePlatform());
}

class ThePlatform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error initializing firebase");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: LandingPage(
              auth: Auth(),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
