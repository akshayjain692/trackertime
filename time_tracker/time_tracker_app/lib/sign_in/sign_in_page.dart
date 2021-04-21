import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_app/sign_in/sign_in_button.dart';
import 'package:time_tracker_app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") return;

    showExceptionAlertDialog(
      context,
      title: "Sign In Failed",
      exception: exception,
    );
  }

  Future<void> _signInAnonymosuly(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final authBase = Provider.of<AuthBase>(context, listen: false);

      await authBase.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    final authBase = Provider.of<AuthBase>(context, listen: false);

    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final authBase = Provider.of<AuthBase>(context, listen: false);
      await authBase.singInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final authBase = Provider.of<AuthBase>(context, listen: false);
      await authBase.signInWithfacebook();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time tracker"),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
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
            onpressed: _isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assestName: "images/facebook-logo.png",
            text: "Sign in with Facebook",
            textColor: Colors.white,
            onpressed: _isLoading ? null : () => _signInWithFacebook(context),
            color: Color(0xFF334D92),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            onpressed: _isLoading ? null : () => _signInWithEmail(context),
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
            onpressed: _isLoading ? null : () => _signInAnonymosuly(context),
            color: Colors.lime[300],
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        "Sign In",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      );
    }
  }
}
