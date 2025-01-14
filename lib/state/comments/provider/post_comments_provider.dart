import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:instantgramclonexyz/state/comments/models/comment.dart';
import 'package:instantgramclonexyz/state/comments/models/post_comments_request.dart';
import 'package:instantgramclonexyz/state/constants/firebase_collection_name.dart';
import 'package:instantgramclonexyz/state/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.autoDispose
    .family<Iterable<Comment>, RequestForPostAndComments>((ref, request) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldName.createdAt, descending: request.sortByCreatedAt)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final limited =
        request.limit == null ? documents : documents.take(request.limit!);
    final comments = limited
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map(
          (doc) => Comment(
            doc.data(),
            id: doc.id,
          ),
        )
        .toList();
    final result = comments.applySortingFrom(request);
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
