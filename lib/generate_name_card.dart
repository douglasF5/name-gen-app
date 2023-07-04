import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class GenerateNameCard extends StatelessWidget {
  final WordPair wordPair;

  const GenerateNameCard({required this.wordPair, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.white,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 400.0,
          maxHeight: 250.0,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              Text(
                wordPair.asLowerCase,
                textAlign: TextAlign.center,
                style: theme.textTheme.displayMedium!.copyWith(
                  color: theme.colorScheme.primary,
                ),
                semanticsLabel: '${wordPair.first} ${wordPair.second}',
              ),
              Text(
                '${wordPair.first} + ${wordPair.second}',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
