import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/send_comment_notifier.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/is_loading.dart';

final sendcommentprovider =
    StateNotifierProvider<Sendcommentnotifier, Isloading>(
  (_) => Sendcommentnotifier(),
);
