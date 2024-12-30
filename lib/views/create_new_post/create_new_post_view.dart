import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/user_id_provider.dart';
import 'package:instantgramclonexyz/state/image_upload/models/file_type.dart';
import 'package:instantgramclonexyz/state/image_upload/models/thumbnail_request.dart';
import 'package:instantgramclonexyz/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instantgramclonexyz/state/post_settings/models/post_setting.dart';
import 'package:instantgramclonexyz/state/post_settings/providers/post_settings_provider.dart';
import 'package:instantgramclonexyz/views/components/file_thumbnail_view.dart';
import 'package:instantgramclonexyz/views/constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  const CreateNewPostView({
    required this.fileToPost,
    required this.fileType,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final ThumbnailRequest thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );

    final postSettings = ref.watch(postSettingsProvider);

    final postController = useTextEditingController();

    final isPostButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () => postController.removeListener(listener);
    }, [postController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProviderProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploadProvider.notifier)
                        .uploadImage(
                          userId: userId,
                          file: widget.fileToPost,
                          fileType: widget.fileType,
                          message: message,
                          postSettings: postSettings,
                        );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FileThumbnailView(request: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: Strings.pleaseWriteYourMessageHere,
                ),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),
            ...PostSetting.values.map(
              (setting) {
                return ListTile(
                  title: Text(setting.title),
                  subtitle: Text(setting.description),
                  trailing: Switch(
                    value: postSettings[setting] ?? false,
                    onChanged: (value) {
                      ref
                          .read(postSettingsProvider.notifier)
                          .setSetting(setting, value);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
