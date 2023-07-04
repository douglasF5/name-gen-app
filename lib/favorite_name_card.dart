import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class FavoriteNameCard extends StatelessWidget {
  final WordPair wordPair;
  final void Function(WordPair) action;

  FavoriteNameCard(this.wordPair, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          right: 8.0,
          left: 16.0,
          bottom: 12.0,
        ),
        constraints: BoxConstraints(
          maxWidth: 250.0,
          maxHeight: 150.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.favorite, color: theme.colorScheme.secondary),
                Tooltip(
                  message: 'Remove name',
                  child: IconButton(
                      onPressed: () => action(wordPair),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.deepOrange,
                        semanticLabel: 'Remove from favorites',
                      )),
                ),
              ],
            ),
            SizedBox.square(
              dimension: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    wordPair.asLowerCase,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${wordPair.first} + ${wordPair.second}',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
