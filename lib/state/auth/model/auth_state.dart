import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/auth/model/auth_result.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

@immutable
class AuthState {
  final AuthResult? authresult;
  final bool isLoading;
  final Userid? userid;
  const AuthState(
      {required this.authresult,
      required this.isLoading,
      required this.userid});

  const AuthState.unknown()
      : authresult = null,
        isLoading = true,
        userid = null;
  AuthState copyWith(bool? newIsLoading) =>
      AuthState(authresult: authresult, isLoading: isLoading, userid: userid);
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (authresult == other.authresult &&
          isLoading == other.isLoading &&
          userid == other.userid);

  @override
  
  int get hashCode => Object.hash(authresult, isLoading, userid);
}
