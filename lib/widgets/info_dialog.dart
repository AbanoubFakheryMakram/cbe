import 'package:flutter/material.dart';
import '../l10n/app_localization.dart';

class InfoDialog extends StatelessWidget {
  final String? title;
  final String body;
  String? actionText;
  VoidCallback? onPressed;
  final int maxBodyLines;

  InfoDialog({
    Key? key,
    this.title,
    required this.body,
    this.actionText,
    this.onPressed,
    this.maxBodyLines = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        children: [
          Visibility(
            visible: title != null,
            child: Text(title ?? '', style: const TextStyle()),
          ),
          const Spacer(flex: 1),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
        child: Text(
          body,
          style: const TextStyle(),
          maxLines: maxBodyLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      ElevatedButton(
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: Text(
          actionText ?? AppLocalization.translation.ok,
        ),
      ),
      const SizedBox(height: 15)
    ]);
  }
}
