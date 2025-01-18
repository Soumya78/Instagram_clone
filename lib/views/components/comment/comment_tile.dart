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

  const CommentTile({super.key, required this.comment});

  Widget build(BuildContext context, WidgetRef ref) {
    final userinfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    userinfo.when(data: (userinfomodel) {
      final currentuserid = ref.read(useridprovider);
      return ListTile(
        trailing: currentuserid == comment.fromUserId
            ? IconButton(
                onPressed: () async {
                  final shouldeletecomment = await displaydeletedailog(context);
                  if (shouldeletecomment) {
                    await ref
                        .read(deletecommentprovider.notifier)
                        .deletecomment(commentid: comment.id);
                  }
                },
                icon: const Icon(Icons.delete),
              )
            : null,
        title: Text(userinfomodel.displayName),
        subtitle: Text(comment.comments),
      );
    }, error: (errpr, stacktrace) {
      const SmallErrorAnimation();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    return const Placeholder();
  }

  Future<bool> displaydeletedailog(BuildContext context) =>
      DeleteDialog(titleofobjecttodelete: Strings.comments)
          .present(context)
          .then((value) => value ?? false);
}
