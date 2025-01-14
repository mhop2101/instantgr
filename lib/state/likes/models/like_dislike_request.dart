import 'package:flutter/foundation.dart';

import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;
  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
