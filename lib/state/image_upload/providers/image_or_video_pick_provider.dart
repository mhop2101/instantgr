import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/image_upload/notifiers/image_or_video_pick_notifier.dart';
import 'package:instantgramclonexyz/state/image_upload/typedefs/is_loading.dart';

final imageOrVideoPickLoadingProvider =
    StateNotifierProvider<ImageOrVideoPickNotifier, IsLoading>(
  (ref) => ImageOrVideoPickNotifier(),
);
