import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instantgramclonexyz/state/constants/firebase_field_name.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId userId,
    required DateTime date,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createdAt: date.toIso8601String(),
        });
}
