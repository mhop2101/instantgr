import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:instantgramclonexyz/views/components/rich_text/base_text.dart';
import 'package:instantgramclonexyz/views/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((text) {
          if (text is LinkText) {
            return TextSpan(
              text: text.text,
              style: text.style?.merge(styleForAll),
              recognizer: TapGestureRecognizer()..onTap = text.onTapped,
            );
          } else {
            return TextSpan(
              text: text.text,
              style: text.style?.merge(styleForAll),
            );
          }
        }).toList(),
      ),
    );
  }
}
