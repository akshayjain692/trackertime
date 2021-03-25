import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_1/app/home_page.dart';
import 'package:sample_1/app/services/auth.dart';
import 'package:sample_1/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  final AuthBase authBase;

  const LandingPage({Key key, @required this.authBase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: authBase.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null)
            return SignInPage(
              authBase: authBase,
            );
          else
            return HomePage(
              authBase: authBase,
            );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
