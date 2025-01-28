import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/likes/providers/haslikedpostprovider.dart';
import 'package:instagram_clone/state/likes/providers/like_dislike_provider.dart';
import 'package:instagram_clone/state/likes/providers/models/like_dislike_model.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';

class Likebutton extends ConsumerWidget {
  final PostId postId;

  const Likebutton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasliked = ref.watch(haslikedprovider(postId));
    return hasliked.when(data: (hasliked) {
      return IconButton(onPressed: () {
        final userid = ref.read(useridprovider);
        if(userid == null){
          return ;
        }else{
          final likedislikerequest = LikedislikeRequest(postid: postId, likedby: userid);
          ref.read(likedislikeprovider(likedislikerequest));
        }
      },
          icon: FaIcon(
              hasliked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart));
    }, error: (e, stacktrace) {
     return const SmallErrorAnimation();
    }, loading: () {
      return const Center(child: CircularProgressIndicator(),);
    });
  }
}
