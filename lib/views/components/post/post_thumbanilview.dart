import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

class PostThumbanilview extends StatelessWidget {
  final Post post  ;
  final VoidCallback callback;
  const PostThumbanilview(
      {super.key, required this.post, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Image.network(
          post.thumbnail,
          fit: BoxFit.cover,
        ));
  }
}
