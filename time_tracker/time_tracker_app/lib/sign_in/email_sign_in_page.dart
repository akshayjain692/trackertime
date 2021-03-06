import 'package:flutter/material.dart';
import 'package:time_tracker_app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: EmailSignInForm(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
