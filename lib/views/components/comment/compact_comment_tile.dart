import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';


import '../../../state/comments/typedef/model/comment.dart';
import '../rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
    userInfoModelProvider(
        comment.fromUserId,
      ),
    );
    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(
          leftpart: userInfo.displayName,
          rightpart: comment.comments,
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimation();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}