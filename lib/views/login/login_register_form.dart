import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/auth_state_provider.dart';
import 'package:instantgramclonexyz/views/constants/app_colors.dart';
import 'package:instantgramclonexyz/views/constants/strings.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
    required this.createAccount,
  });
  final bool createAccount;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          widget.createAccount
              ? TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )
              : const SizedBox(),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // Basic email validation regex
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          TextButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                if (widget.createAccount) {
                  ref
                      .read(authStateProvider.notifier)
                      .signUpWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text);
                } else {
                  ref
                      .read(authStateProvider.notifier)
                      .loginWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                }
              }
            },
            child: widget.createAccount
                ? Text(
                    Strings.createAccount,
                    style: TextStyle(color: AppColors.loginButtonColor),
                  )
                : Text(
                    Strings.login,
                    style: TextStyle(color: AppColors.loginButtonColor),
                  ),
          ),
        ],
      ),
    );
  }
}
