import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// user class
class MyUser {
  MyUser(this.uid);
  final String uid;
}

// abstract class for global paging

abstract class MyAuthBase {
  Future<User> currentUser();
  Future<User> signInWithEmail(String mail, String password);
  Future<void> signOut();
  Future<User> createAccountWithEmail(String mail, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Stream<User> get onAuthStateChanged;
}

// main class

class Auth implements MyAuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  // method to use firebase user only here
  User _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return _firebaseAuth.currentUser;
    }
  }

  // stream to add listener
  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

// method to get current user info
  @override
  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  // method to sign in with email and password
  @override
  Future<User> signInWithEmail(String mail, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createAccountWithEmail(String mail, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  // sign in with google account
  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: "INVALID TOKEN",
          message: "Token is invalid for this user",
        );
      }
    } else {
      throw PlatformException(
        code: "ABORTED",
        message: "User aborted google sign in",
      );
    }
  }

  // method to sign in with facebook
  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
      ["public_profile"],
    );

    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(
          result.accessToken.token,
        ),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: "FB_LOGIN_ABORTED",
        message: "User canceled facebook login",
      );
    }
  }

  // method to sign out
  @override
  Future<void> signOut() async {
    final googleSignin = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await googleSignin.signOut();
    await _firebaseAuth.signOut();
  }
}
