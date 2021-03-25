import 'package:flutter/material.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/services/auth_provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final authBase = AuthProvider.of(context);
      await authBase.signOut();
    } catch (e) {}
  }

  Future<void> _confirmsSignOut(BuildContext context) async {
    final didRequestSignout = await showAlertDialog(
      context,
      title: "Sign Out",
      content: "Are you sure you want to logut",
      defaultActionText: "Logout",
      cancelActionText: "Cancel",
    );
    if (didRequestSignout) _signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: () => _confirmsSignOut(context),
          ),
        ],
      ),
    );
  }
}
