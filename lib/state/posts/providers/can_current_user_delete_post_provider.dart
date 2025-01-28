import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

final cancurrentuserdeletepostprovider = StreamProvider.family.autoDispose<bool,Post>((ref, Post post) async*{
  final userid = ref.watch(useridprovider);
  yield userid == post.Userid ;
});