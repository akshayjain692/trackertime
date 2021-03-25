import 'package:flutter/cupertino.dart';
import 'package:sample_1/common_widgets/custom_raise_button.dart';

class SignInButton extends CustomRaiseButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onpressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
          color: color,
          onPresssed: onpressed,
        );
}
