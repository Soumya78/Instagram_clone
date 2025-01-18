import 'dart:collection' show MapView;
import'package:flutter/foundation.dart' show immutable;


import '../../constants/firebase_field_name.dart';
import '../../typedef/post/user_id.dart';

@immutable
class Userinfomodel extends MapView<String, String?> {
  final Userid userid;
  final String displayName;
  final String? email;

  Userinfomodel({
    required this.userid,
    required this.displayName,
    required this.email,
  }) : super(
      {
   FirebaseFieldName.userid:userid,
    FirebaseFieldName.displayname: displayName,
    FirebaseFieldName.email: email,
  }
  );

  Userinfomodel.fromJson(
    Map<String, dynamic> json, {
        required Userid userid,
      }
  ) :this(
    userid: userid,
    displayName: json[FirebaseFieldName.displayname] ?? '',
    email: json[FirebaseFieldName.email],
  );



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Userinfomodel &&
              runtimeType == other.runtimeType &&
              userid == other.userid &&
              displayName == other.displayName &&
              email == other.email;

  @override
  int get hashCode => Object.hashAll(
    [
      userid,
      displayName,
      email,
    ],
  );
}