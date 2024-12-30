import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() => _imagePicker
      .pickImage(source: ImageSource.gallery)
      .then((file) => file?.path != null ? File(file!.path) : null);

  static Future<File?> pickVideoFromGallery() => _imagePicker
      .pickVideo(source: ImageSource.gallery)
      .then((file) => file?.path != null ? File(file!.path) : null);
}
