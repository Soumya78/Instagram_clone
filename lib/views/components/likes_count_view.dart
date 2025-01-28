import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';
import 'package:instagram_clone/state/likes/providers/post_like_count_provider.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postid ;
  const LikesCountView({super.key,required this.postid});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final likescount = ref.watch(postlikescountprovider(postid));
    return likescount.when(data:(int likescount){
      final personorpeople = likescount == 1 ? Strings.person : Strings.people ;
      final likestext = '$likescount $personorpeople ${Strings.likedThis}';
      return Text(likestext);
    } , error: (e,stacktrace){
      return SmallErrorAnimation();
    }, loading: (){
      return const CircularProgressIndicator();
    });
  }
}
