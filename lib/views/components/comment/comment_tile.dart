import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/typedef/model/comment.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/providers/delete_comments_provider.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_dailog.dart';

import '../../constants/strings.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({
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
        final currentUserId = ref.read(useridprovider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    print('Delteting process starts');
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);
                    print(shouldDeleteComment);
                    if (shouldDeleteComment) {
                      await ref
                          .read(
                            deletecommentprovider.notifier,
                          )
                          .deletecomment(
                            commentid: comment.id,
                          );
                    }
                    print('Deleting process ended');
                  },

                )
              : null,
          title: Text(
            userInfo.displayName,
          ),
          subtitle: Text(
            comment.comments,
          ),
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

  Future<bool> displayDeleteDialog(BuildContext context) =>
      DeleteDialog(titleofobjecttodelete: Strings.comments)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
