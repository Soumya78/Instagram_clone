import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/image_upload/model/providers/thumbnail_provider.dart';
import 'package:instagram_clone/state/image_upload/model/thumbnailrequest.dart';
import 'package:instagram_clone/views/components/componets/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/components/componets/animations/small_error_animation.dart';

class Filethumbnailview extends ConsumerWidget {
  final Thumbnailrequest thumbnailrequest;

  const Filethumbnailview({super.key, required this.thumbnailrequest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailprovider(thumbnailrequest));
    return thumbnail.when(
      data: (imagewithasceptratio) {
        return AspectRatio(
            aspectRatio: imagewithasceptratio.aspectratio,
            child: imagewithasceptratio.image);
      },
      loading: () {
        return const LoadingAnimationView();
      },
      error: (error, stackTrace) {
        print('Error: $error');
        print('Stack trace: $stackTrace');
        return const SmallErrorAnimation();
      },
    );
  }
}
