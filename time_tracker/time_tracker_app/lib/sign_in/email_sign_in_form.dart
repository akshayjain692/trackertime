import 'dart:io';

import 'package:flutter/material.dart';
import 'package:time_tracker_app/common_widgets/form_submit_button.dart';
import 'package:time_tracker_app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/auth_provider.dart';
import 'package:time_tracker_app/sign_in/validators.dart';

enum EmailSignInType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  @override
  EmailSignInFormState createState() => EmailSignInFormState();
}

class EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  EmailSignInType _formType = EmailSignInType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _toggleFormType() {
    setState(() {
      _submitted = false;

      _formType = _formType == EmailSignInType.signIn
          ? EmailSignInType.register
          : EmailSignInType.signIn;
    });
  }

  void _submitButton() async {
    final auth = AuthProvider.of(context);
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      switch (_formType) {
        case EmailSignInType.signIn:
          await auth.signInWithEmailAndPassword(_email, _password);
          break;
        case EmailSignInType.register:
          await auth.createUserWithEmailAndPassword(_email, _password);
          break;
      }
      Navigator.of(context).pop();
    } catch (e) {
      // TODO
      showAlertDialog(
        context,
        title: "Sign in fail",
        content: e.toString(),
        defaultActionText: "Ok",
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildChildren() {
    final authBase = AuthProvider.of(context);
    final primaryText =
        _formType == EmailSignInType.signIn ? "Sign In" : "Create an account";
    final secondaryText = _formType == EmailSignInType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";

    bool submitButtonEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailField(),
      SizedBox(
        height: 8,
      ),
      _buildPasswordField(),
      SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitButtonEnabled ? _submitButton : null,
      ),
      SizedBox(
        height: 8,
      ),
      TextButton(
        child: Text(
          secondaryText,
        ),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordField() {
    bool showPasswordText =
        _submitted && !widget.emailValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submitButton,
      focusNode: _passwordFocusNode,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Password",
        enabled: !_isLoading,
        errorText: showPasswordText ? widget.invalidPasswordErrorText : null,
      ),
    );
  }

  Widget _buildEmailField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      autocorrect: false,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingCompleted,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "test@abc.com",
        enabled: !_isLoading,
        labelText: "Email",
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _emailEditingCompleted() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  _updateState() {
    setState(() {});
  }
}
