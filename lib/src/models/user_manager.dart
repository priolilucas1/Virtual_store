import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/src/models/user.dart' as us;

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(us.User user) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print(result.user?.uid);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
