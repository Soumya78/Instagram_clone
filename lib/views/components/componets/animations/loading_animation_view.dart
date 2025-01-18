import 'package:instagram_clone/views/components/componets/animations/lottieanimationview.dart';
import 'package:instagram_clone/views/components/componets/animations/model/lottieanimation.dart';

class LoadingAnimationView extends Lottieanimationview {
  const LoadingAnimationView({super.key})
      : super(lottieAnimation: LottieAnimation.loading);
}