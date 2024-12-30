import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/post_settings/models/post_setting.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingsNotifier()
      : super(
            // {
            //   PostSetting.allowLikes: true,
            //   PostSetting.allowComments: true,
            // },
            UnmodifiableMapView({
          for (final setting in PostSetting.values) setting: true,
        }));

  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.of(state)..[setting] = value;
  }
}
