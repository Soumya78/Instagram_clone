import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';
import 'package:instagram_clone/views/components/componets/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/componets/animations/loading_animation_view.dart';
import 'package:video_player/video_player.dart';

class PostVedioView extends HookWidget {
  final Post post;

  const PostVedioView({super.key, required this.post,});

  @override
  Widget build(BuildContext context) {
    final fileurl = Uri.parse(post.fileurl);
    final controller = VideoPlayerController.networkUrl(fileurl);
    final isvedioplayerready = useState(false);
    useEffect(() {
      controller.initialize().then((value) {
        isvedioplayerready.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose ;
    },[controller]);
    switch(isvedioplayerready.value){
      case true:
        return AspectRatio(aspectRatio: post.aspectratio,child: VideoPlayer(
            controller),);
      case false:
        return const LoadingAnimationView();
      default:
        return const ErrorAnimationView();
    }

  }
}

