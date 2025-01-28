import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/state/posts/providers/post_by_search_term_provider.dart';
import 'package:instagram_clone/state/posts/providers/typedefs/search_term.dart';
import 'package:instagram_clone/views/components/componets/animations/data_not_found_animation_view.dart';
import 'package:instagram_clone/views/components/componets/animations/emptycontentswithtextanimationview.dart';
import 'package:instagram_clone/views/components/componets/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/componets/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/post/post_sliver_grid_view.dart';
import 'package:instagram_clone/views/components/post/posts_gridview.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class SearchViewGrid extends ConsumerWidget {
  final SearchTerm searchTerm;

  const SearchViewGrid({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
          child: Emptycontentswithtextanimationview(
              text: Strings.enterYourSearchTerm),);
    }
    final post = ref.watch(postbysearchtermprovider(searchTerm));
    return post.when(data: (data) {
      if (data.isEmpty) {
        return const SliverToBoxAdapter(
          child: DataNotFoundAnimationView(),
        );
      } else {
        return PostsSliverGridView(posts: data);
      }
    }, error: (e, stacktrace) {
      return const SliverToBoxAdapter(
          child: ErrorAnimationView());
    }, loading: () {
      return const SliverToBoxAdapter(
          child: LoadingAnimationView());
    });
  }
}
