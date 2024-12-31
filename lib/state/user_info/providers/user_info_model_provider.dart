import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/constants/firebase_collection_name.dart';
import 'package:instantgramclonexyz/state/constants/firebase_field_name.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';
import 'package:instantgramclonexyz/state/user_info/models/user_info_model.dart';

final userInfoModelProvider =
    StreamProvider.autoDispose.family<UserInfoModel, UserId>(
  (ref, userId) {
    final controller = StreamController<UserInfoModel>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(
          FirebaseFieldName.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          final data = doc.data();
          final userInfo = UserInfoModel.fromJson(
            data,
            userId: userId,
          );
          controller.add(userInfo);
        }
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
