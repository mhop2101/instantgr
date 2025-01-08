import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instantgramclonexyz/state/posts/models/post.dart';
import 'package:instantgramclonexyz/views/components/animations/error_animation.dart';
import 'package:instantgramclonexyz/views/components/animations/loading_animation.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Post post;

  const PostVideoView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final controller = VideoPlayerController.network(
      post.fileUrl,
    );

    final isVideoPlayerReady = useState(false);

    useEffect(
      () {
        controller.initialize().then(
          (value) {
            isVideoPlayerReady.value = true;
            controller.setLooping(true);
            controller.play();
          },
        );
        return controller.dispose;
      },
      [controller],
    );

    switch (isVideoPlayerReady.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return const Center(
          child: LoadingAnimationView(),
        );
    }
  }
}