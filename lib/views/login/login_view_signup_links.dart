import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/create_account_provider.dart';
import 'package:instantgramclonexyz/views/constants/strings.dart';
import 'package:instantgramclonexyz/views/components/rich_text/base_text.dart';
import 'package:instantgramclonexyz/views/components/rich_text/rich_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignupLinks extends ConsumerWidget {
  const LoginViewSignupLinks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichTextWidget(
      styleForAll: const TextStyle(
        fontSize: 15,
      ),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.link(
          text: Strings.signUpOn,
          onTapped: () {
            ref.read(createAccountProvider.notifier).toggle();
          },
        ),
        BaseText.plain(
          text: Strings.orCreateAnAccountOn,
        ),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(
                Strings.googleSignupUrl,
              ),
            );
          },
        ),
      ],
    );
  }
}
