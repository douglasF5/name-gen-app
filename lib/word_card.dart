import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class WordCard extends StatelessWidget {
  final WordPair wordPair;

  const WordCard({required this.wordPair, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 350.0, maxHeight: 150.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            textAlign: TextAlign.center,
            wordPair.asLowerCase,
            style: style,
            semanticsLabel: '${wordPair.first} ${wordPair.second}',
          ),
        ),
      ),
    );
  }
}
