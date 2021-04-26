import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void disose() {
    _isLoadingController.close();
  }

  void _setIsLoadingController(bool isloading) =>
      _isLoadingController.add(isloading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoadingController(true);
      return signInMethod();
    } catch (e) {
      _setIsLoadingController(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User> singInWithGoogle() async => await _signIn(auth.singInWithGoogle);

  Future<User> signInWithfacebook() async =>
      await _signIn(auth.signInWithfacebook);
}
