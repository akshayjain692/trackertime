import 'package:flutter/material.dart';
import 'package:sample_1/common_widgets/custom_raise_button.dart';

class SocialSignInButton extends CustomRaiseButton {
  SocialSignInButton({
    @required String text,
    @required String assestName,
    Color color,
    Color textColor,
    VoidCallback onpressed,
  })  : assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assestName),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(opacity: 0, child: Image.asset(assestName)),
            ],
          ),
          color: color,
          onPresssed: onpressed,
        );
}
