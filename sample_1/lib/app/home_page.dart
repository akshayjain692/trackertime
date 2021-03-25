import 'package:flutter/material.dart';
import 'package:sample_1/app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase authBase;

  const HomePage({Key key, @required this.authBase}) : super(key: key);

  Future<void> _signOutAnonymosuly() async {
    try {
      await authBase.signOut();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: _signOutAnonymosuly,
          ),
        ],
      ),
    );
  }
}
