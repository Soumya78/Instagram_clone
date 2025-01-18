import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/state/auth/constants/constatnts.dart';
import 'package:instagram_clone/state/auth/model/auth_result.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

class Authenticatior {

  User? get currentuser => FirebaseAuth.instance.currentUser;
  Userid? get user_id => currentuser?.uid;
  bool get isloggedin => user_id != null;
  String get displayname => currentuser?.displayName ?? 'none';
  String? get email => currentuser?.email;
  ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://instagramclonecourse.page.link/finishsignin');
  String get link => 'https://instagramclonecourse.page.link/finishsignin';
  late List<String> providerid;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> loginwithfacebook() async {
    final loginresult = await FacebookAuth.instance.login();
    final token = loginresult.accessToken?.tokenString;
    if (token == null) {
      return AuthResult.aborted;
    }
    final oAuthCredential = FacebookAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      return AuthResult.sucess;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountexisitwithdiffrentcredential &&
          email != null &&
          credential != null) {
        final provider = await FirebaseAuth.instance
            .signInWithEmailLink(email: email, emailLink: link);
        final user = provider.user;
        if (user != null) {
          providerid =
              user.providerData.map((userinfo) => userinfo.providerId).toList();
        }
        if (providerid.contains(Constants.googlecom)) {
          await loginwithgoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.sucess;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginwithgoogle() async {
    final GoogleSignIn googlesignin = GoogleSignIn(scopes: [Constants.email]);
    final signinaccount = await googlesignin.signIn();
    if (signinaccount == null) {
      return AuthResult.aborted;
    }
    final googleauth = await signinaccount.authentication;
    final oAuthCredential = GoogleAuthProvider.credential(
        idToken: googleauth.idToken, accessToken: googleauth.accessToken);
        try{
          await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
          return AuthResult.sucess;
        }on Exception{
          return AuthResult.failure;
        }
  }
}
