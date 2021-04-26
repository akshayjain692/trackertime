import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/show_exception_alert.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_app/sign_in/sign_in_button.dart';
import 'package:time_tracker_app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;

  const SignInPage({Key key, @required this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.disose(),
      child: Consumer<SignInBloc>(
          builder: (_, bloc, __) => SignInPage(
                bloc: bloc,
              )),
    );
  }

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
      await bloc.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
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
      await bloc.singInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithfacebook();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time tracker"),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
            child: _buildHeader(isLoading),
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
            onpressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assestName: "images/facebook-logo.png",
            text: "Sign in with Facebook",
            textColor: Colors.white,
            onpressed: isLoading ? null : () => _signInWithFacebook(context),
            color: Color(0xFF334D92),
          ),
          SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            onpressed: isLoading ? null : () => _signInWithEmail(context),
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
            onpressed: isLoading ? null : () => _signInAnonymosuly(context),
            color: Colors.lime[300],
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
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
