import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/src/helpers/firebase_errors.dart';
import 'package:loja_virtual/src/models/user.dart' as us;

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({
    required us.User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
