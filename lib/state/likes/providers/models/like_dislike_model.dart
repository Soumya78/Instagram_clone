import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';
@immutable
class LikedislikeRequest {
  final PostId postid ;
  final Userid likedby;

 const  LikedislikeRequest({required this.postid, required this.likedby});

}