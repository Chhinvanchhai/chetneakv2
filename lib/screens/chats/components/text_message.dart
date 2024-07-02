import 'package:chetneak_v2/models/ChatMessage.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.isSender) {
      return Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? const Color.fromARGB(255, 234, 233, 236)
                : const Color.fromARGB(255, 35, 42, 41),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            softWrap: true,
          ),
        ),
      );
    }

    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.75, // Limit the max width
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
