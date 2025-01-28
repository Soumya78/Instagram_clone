import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';
import 'package:instagram_clone/views/components/rich_two_parts_text.dart';

import '../../../state/typedef/post/post.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;

  const PostDisplayNameAndMessageView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userinfomodel = ref.watch(userInfoModelProvider(post.Userid));

    return userinfomodel.when(data: (userinfomodel) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(
            leftpart: userinfomodel.displayName,
            rightpart: post.message,
          ));
    }, error: (e, stacktrace) {
      return SmallErrorAnimation();
    }, loading: () {
      return const Center(child: CircularProgressIndicator(),);
    });
  }
}
