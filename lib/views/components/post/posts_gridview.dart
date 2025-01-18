import 'package:flutter/material.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';
import 'package:instagram_clone/views/components/post/post_thumbanilview.dart';
import 'package:instagram_clone/views/post_comments/post_comments_view.dart';

class PostsGridview extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsGridview({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts.elementAt(index);
          return PostThumbanilview(
              post: post,
              callback: () {
                print("Pushing to Postcommentviewstartee");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Postcommentview(postid: post.postid),
                  ),

                );
                print("Pushing to Postcommentviewended");
              });
        });
  }
}
