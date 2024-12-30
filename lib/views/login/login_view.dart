import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/auth_state_provider.dart';
import 'package:instantgramclonexyz/state/auth/providers/create_account_provider.dart';
import 'package:instantgramclonexyz/views/constants/app_colors.dart';
import 'package:instantgramclonexyz/views/constants/strings.dart';
import 'package:instantgramclonexyz/views/login/components/divider_with_margins.dart';
import 'package:instantgramclonexyz/views/login/google_button.dart';
import 'package:instantgramclonexyz/views/login/login_view_signup_links.dart';
import 'package:instantgramclonexyz/views/login/login_register_form.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool createAccount = ref.watch(createAccountProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  Strings.welcomeToAppName,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const DividerWithMargins(),
                Text(
                  Strings.logIntoYourAccount,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                LoginForm(createAccount: createAccount),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    ref.read(authStateProvider.notifier).loginWithGoogle();
                  },
                  child: const GoogleButton(),
                ),
                const DividerWithMargins(),
                const LoginViewSignupLinks(),
              ],
            ),
          ),
        ));
  }
}
