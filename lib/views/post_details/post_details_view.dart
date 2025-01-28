import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/enums/datesorting.dart';
import 'package:instagram_clone/state/comments/typedef/model/postcommentsrequest.dart';
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone/state/posts/providers/delete_post_providers.dart';
import 'package:instagram_clone/state/posts/providers/specific_post_with_comments.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';
import 'package:instagram_clone/views/components/comment/comment_tile.dart';
import 'package:instagram_clone/views/components/comment/compact_comment_column.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_dailog.dart';
import 'package:instagram_clone/views/components/likebutton.dart';
import 'package:instagram_clone/views/components/likes_count_view.dart';
import 'package:instagram_clone/views/components/post/post_date_view.dart';
import 'package:instagram_clone/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_clone/views/components/post/post_image_or_vedio.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailsView({super.key, required this.post});

  @override
  ConsumerState<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final requestforpostandcomments = RequestForPostAndComments(
        postid: widget.post.postid,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: Datesorting.oldestontop);

    final postwithcomments =
        ref.watch(specificpostwithcommentprovider(requestforpostandcomments));

    final candeletepost =
        ref.watch(cancurrentuserdeletepostprovider(widget.post));

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          postwithcomments.when(
            data: (postwithcomments) {
              return IconButton(
                onPressed: () {
                  final url = postwithcomments.post.fileurl;
                  Share.share(url, subject: Strings.checkOutThisPost);
                },
                icon: const Icon(Icons.share),
              );
            },
            error: (e, stacktrace) {
              return const SmallErrorAnimation();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          if (candeletepost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shoulddeletepost =
                    await DeleteDialog(titleofobjecttodelete: Strings.post)
                        .present(context)
                        .then((shoulddelete) => shoulddelete ?? false);
                if (shoulddeletepost) {
                  await ref
                      .read(deletepostprovider.notifier)
                      .deletepost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            )
        ],
      ),
      body: postwithcomments.when(data: (postwithcomments) {
        final postId = postwithcomments.post.postid;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PostImageOrVedio(post: postwithcomments.post),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (postwithcomments.post.allowlikes)
                    Likebutton(postId: postId),
                  if (postwithcomments.post.allowcomments)
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Postcommentview(postid: postId),
                            ),
                          );
                        },
                        icon: const Icon(Icons.mode_comment_outlined))
                ],
              ),
              //This is not working
              PostDisplayNameAndMessageView(post: postwithcomments.post),
              PostDateView(dateTime: postwithcomments.post.createdate),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              CompactCommentsColumn(comments: postwithcomments.comment),
              if (postwithcomments.post.allowlikes)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [LikesCountView(postid: postId)],
                  ),
                ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        );
      }, error: (e, stacktrace) {
        return const SmallErrorAnimation();
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
