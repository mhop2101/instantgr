import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/image_upload/typedefs/is_loading.dart';

class ImageOrVideoPickNotifier extends StateNotifier<IsLoading> {
  ImageOrVideoPickNotifier() : super(false);

  set isLoading(bool value) => state = value;

  void setImageOrVideoPickerLoading({required bool state}) {
    isLoading = state;
  }
}
