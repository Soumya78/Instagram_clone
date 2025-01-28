import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';
import 'package:instagram_clone/state/posts/providers/notifier/delete_post_state_notifier.dart';

final deletepostprovider = StateNotifierProvider<Deletepoststatenotfier,Isloading>((ref)=> Deletepoststatenotfier());