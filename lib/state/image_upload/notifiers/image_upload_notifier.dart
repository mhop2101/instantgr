import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/constants/firebase_collection_name.dart';
import 'package:instantgramclonexyz/state/image_upload/constants/constants.dart';
import 'package:instantgramclonexyz/state/image_upload/exceptions/could_not_build_thumbnail_expception.dart';
import 'package:instantgramclonexyz/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instantgramclonexyz/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:instantgramclonexyz/state/image_upload/models/file_type.dart';
import 'package:instantgramclonexyz/state/image_upload/typedefs/is_loading.dart';
import 'package:instantgramclonexyz/state/post_settings/models/post_setting.dart';
import 'package:instantgramclonexyz/state/posts/models/post_payload.dart';
import 'package:instantgramclonexyz/state/posts/typedefs/user_id.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> uploadImage(
      {required File file,
      required FileType fileType,
      required String message,
      required Map<PostSetting, bool> postSettings,
      required UserId userId}) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExpception();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailExpception();
        }
        thumbnailUint8List = thumb;
        break;
    }
    // aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();

    // calculate references
    final fileName = const Uuid().v4();

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      // upload thumbnail

      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      // upload original

      final originalFileUploadTask = await originalRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final PostPayload postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        originalFileStorageId: originalFileStorageId,
        thumbnailStorageId: thumbnailStorageId,
        postSettings: postSettings,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
