import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/backend/authenticatior.dart';
import 'package:instagram_clone/state/auth/model/auth_result.dart';
import 'package:instagram_clone/state/auth/model/auth_state.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';
import 'package:instagram_clone/state/user_info/backend/user_info_storage.dart';

class AuthstateNotifier extends StateNotifier<AuthState> {
  final _authenticatior = Authenticatior();
  final _userinfostorage = const UserInfoStorage();

  AuthstateNotifier() : super(const AuthState.unknown()) {
    if (_authenticatior.isloggedin) {
      state = AuthState(
          authresult: AuthResult.sucess,
          isLoading: false,
          userid: _authenticatior.user_id);
    }
  }
    

    // ignore: unused_element
    Future<void> loginwithgoogle() async {
      state = state.copyWith(true);

      final result = await _authenticatior.loginwithgoogle();
      final userid = _authenticatior.user_id;
      if (result == AuthResult.sucess && userid != null) {
        await saveuserinfo(userid: userid);
      }
      state = AuthState(
        authresult: result,
        isLoading: false,
        userid: userid,
      );
      
    }
      Future<void> loginwithfacebook() async {
      state = state.copyWith(true);

      final result = await _authenticatior.loginwithfacebook();
      final userid = _authenticatior.user_id;
      if (result == AuthResult.sucess && userid != null) {
        await saveuserinfo(userid: userid);
      }
      state = AuthState(
        authresult: result,
        isLoading: false,
        userid: userid,
      );
      
    }
  
  
  
   Future<void> saveuserinfo({required Userid userid}) {
      return _userinfostorage.saveuserinfo(
        uid: userid,
        email: _authenticatior.email,
        displayname: _authenticatior.displayname,
      );
   }
      Future<void> logout() async {
      state = state.copyWith(true);
      await _authenticatior.logout();
      state = const AuthState.unknown();
    }
}


