import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instantgramclonexyz/views/components/rich_text/link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) {
    return BaseText(
      text: text,
      style: style,
    );
  }

  factory BaseText.link({
    required String text,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
    required VoidCallback onTapped,
  }) {
    return LinkText(
      text: text,
      style: style,
      onTapped: onTapped,
    );
  }
}
