import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/constants/firebase_collection_name.dart';
import 'package:instantgramclonexyz/state/constants/firebase_field_name.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/post_id.dart';

final hasLikedPostProvider = StreamProvider.family.autoDispose<bool, PostId>(
  (ref, posId) {
    final userId = ref.watch(userIdProviderProvider);
    if (userId == null) {
      return Stream<bool>.value(false);
    }

    final controller = StreamController<bool>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .where(FirebaseFieldName.postId, isEqualTo: posId)
        .snapshots()
        .listen(
      (event) {
        controller.add(event.docs.isNotEmpty);
      },
    );

    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);
