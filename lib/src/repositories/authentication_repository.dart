import 'package:authentication/src/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User> signInWithEmailAndPassword(LoginModel loginModel) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User> singUpwithEmailAndPassword(LoginModel loginModel) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }
}
