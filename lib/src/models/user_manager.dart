import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/src/helpers/firebase_errors.dart';
import 'package:loja_virtual/src/models/user.dart' as us;

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn({
    required us.User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
  }
}
