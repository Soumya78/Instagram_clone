import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';
import 'package:instagram_clone/state/post_settings/notifiers/post_settings_notifier.dart';

final postsettingprovider =
    StateNotifierProvider<PostsettingNotifier, Map<Postsettings, bool>>(
  (ref) => PostsettingNotifier(),
);
