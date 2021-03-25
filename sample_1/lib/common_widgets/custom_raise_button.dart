import 'package:flutter/material.dart';

class CustomRaiseButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPresssed;
  final double height;

  CustomRaiseButton(
      {this.child,
      this.color,
      this.borderRadius: 8.0,
      this.onPresssed,
      this.height: 60});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        onPressed: onPresssed,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }
}
