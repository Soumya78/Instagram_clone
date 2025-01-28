import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/post/post_thumbanilview.dart';

import '../../../state/typedef/post/post.dart';
import '../../post_details/post_details_view.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbanilview(
            post: post,
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsView(
                    post: post,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
