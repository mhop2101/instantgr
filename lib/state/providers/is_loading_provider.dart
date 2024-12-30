import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/auth_state_provider.dart';
import 'package:instantgramclonexyz/state/image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadImageLoading = ref.watch(imageUploadProvider);
  return authState.isLoading || isUploadImageLoading;
});
