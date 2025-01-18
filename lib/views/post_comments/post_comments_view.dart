import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/typedef/model/postcommentsrequest.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/providers/post_comments_provider.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/views/components/comment/comment_tile.dart';
import 'package:instagram_clone/views/components/componets/animations/emptycontentswithtextanimationview.dart';
import 'package:instagram_clone/views/components/componets/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/componets/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/extensions/dissmiss_keyboard.dart';

class Postcommentview extends HookConsumerWidget {
  final PostId postid;

  const Postcommentview({super.key, required this.postid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentcontroller = useTextEditingController();
    final hastext = useState(false);
    final request = useState(RequestForPostAndComments(postid: postid));
    final comments = ref.watch(postcommentprovider(request.value));
    comments.when(
      data: (data) {
        print("Comments: ${data.length}"); // Print the fetched comments
      },
      loading: () {
        print("Loading comments..."); // The provider is still fetching data
      },
      error: (error, stackTrace) {
        print("Error fetching comments: $error"); // Handle any errors
      },
    );
    useEffect(() {
      commentcontroller.addListener(() {
        hastext.value = commentcontroller.text.isNotEmpty;
      });
      return () {};
    }, [commentcontroller]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hastext.value
                ? () {
                    _sumbitcommentwithcontroller(commentcontroller, ref);
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(data: (comment) {
                if (comment.isEmpty) {
                  return const SingleChildScrollView(
                    child: Emptycontentswithtextanimationview(
                        text: Strings.noCommentsYet),
                  );
                }
                return RefreshIndicator(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final comments = comment.elementAt(index);
                        return CommentTile(comment: comments);
                      },
                      itemCount: comment.length,
                    ),
                    onRefresh: () {
                      ref.refresh(
                        postcommentprovider(request.value),
                      );
                      return Future.delayed(const Duration(seconds: 1));
                    });
              }, error: (error, stacktrace) {
                return const ErrorAnimationView();
              }, loading: () {
                return const LoadingAnimationView();
              }),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentcontroller,
                    onSubmitted: (comment) {
                      _sumbitcommentwithcontroller(commentcontroller, ref);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Strings.writeYourCommentHere),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _sumbitcommentwithcontroller(

      TextEditingController controller, WidgetRef ref) async {
    print("This is working");
    final userid = ref.read(useridprovider);
    if (userid == null) {
      return;
    }
    final issent = await ref
        .read(sendcommentprovider.notifier)
        .sendcomment(userid: userid, postid: postid, comment: controller.text);
    print("Comment sent: $issent for postId: $postid");
    if (issent) {
      controller.clear();
      dissmissKeyboard();
    }
  }
}
