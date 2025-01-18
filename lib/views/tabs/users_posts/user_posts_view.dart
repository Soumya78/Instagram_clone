import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/posts/providers/user_posts_provider.dart';
import 'package:instagram_clone/views/components/componets/animations/emptycontentswithtextanimationview.dart';
import 'package:instagram_clone/views/components/componets/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/post/posts_gridview.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userpostprovider);
    return RefreshIndicator(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Emptycontentswithtextanimationview(
                text: Strings.youHaveNoPosts);
          } else {
            return PostsGridview(posts: posts);
          }
        },
        error: (error, StackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const ErrorAnimationView();
        },
      ),
      onRefresh: () {
        ref.refresh(userpostprovider);
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
