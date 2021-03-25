import 'package:flutter/material.dart';
import 'package:sample_1/app/services/auth.dart';
import 'package:sample_1/app/sign_in/sign_in_button.dart';
import 'package:sample_1/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  final AuthBase authBase;
  const SignInPage({Key key, @required this.authBase}) : super(key: key);

  Future<void> _signInAnonymosuly() async {
    try {
      await authBase.signInAnonymously();
    } catch (e) {}
  }

  Future<void> _signInWithGoogle() async {
    try {
      await authBase.singInWithGoogle();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time tracker"),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 48,
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assestName: "images/google-logo.png",
            text: "Sign in to Google",
            textColor: Colors.black87,
            color: Colors.white,
            onpressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assestName: "images/facebook-logo.png",
            text: "Sign in with Facebook",
            textColor: Colors.white,
            onpressed: () {},
            color: Color(0xFF334D92),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            onpressed: () {},
            color: Colors.teal[700],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Or",
            style: TextStyle(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in anonymous",
            onpressed: _signInAnonymosuly,
            color: Colors.lime[300],
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
