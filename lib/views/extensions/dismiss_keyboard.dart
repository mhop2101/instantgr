import 'package:flutter/material.dart';

extension DismissKeyborad on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
