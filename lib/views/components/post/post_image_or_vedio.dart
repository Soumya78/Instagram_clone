import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/views/components/post/post_image_view.dart';
import 'package:instagram_clone/views/components/post/post_vedio_view.dart';

import '../../../state/typedef/post/post.dart';

class PostImageOrVedio extends StatelessWidget {
  final Post post ;
  const PostImageOrVedio({super.key,required this.post});

  @override
  Widget build(BuildContext context) {
    switch (post.filetype) {
      case FileType.image:
        return PostImageView(post: post);
        // TODO: Handle this case.
      case FileType.video:
        return PostVedioView(post: post);
        // TODO: Handle this case.
    }
  }
}
