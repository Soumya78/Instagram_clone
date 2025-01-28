import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/posts/providers/all_post_provider.dart';
import 'package:instagram_clone/views/components/componets/animations/emptycontentsanimationview.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';
import 'package:instagram_clone/views/components/post/posts_gridview.dart';

class Homeview extends ConsumerWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final post = ref.watch(allpostprovider);

    return  RefreshIndicator(child: post.when(data: (posts){
      if(posts.isEmpty){
        return const Emptycontentsanimationview();
      }else{
       return PostsGridview(posts: posts);
      }
    }, error:(e,stacktrace){
      return const SmallErrorAnimation();
    }, loading: (){
      return const Center(child: CircularProgressIndicator(),);
    }), onRefresh: (){
      ref.refresh(allpostprovider);
      return Future.delayed(const Duration(seconds: 1));
    });
  }
}
