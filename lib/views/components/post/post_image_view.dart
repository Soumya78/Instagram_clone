import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

class PostImageView extends StatelessWidget {
  final Post post;

  const PostImageView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: post.aspectratio,
        child: Image.network(
          post.fileurl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingprogress) {
            if (loadingprogress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
