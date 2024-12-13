import 'package:instantgramclonexyz/views/components/animations/lottie_animation_view.dart';
import 'package:instantgramclonexyz/views/components/animations/models/lottie_animations.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(animation: LottieAnimation.loading);
}
