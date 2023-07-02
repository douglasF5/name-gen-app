import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './word_card.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    double gap = 16.0;
    IconData iconFavorite;
    if (appState.favoritesList.contains(pair)) {
      iconFavorite = Icons.favorite;
    } else {
      iconFavorite = Icons.favorite_border_outlined;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random awesome idea:'),
            SizedBox.square(dimension: gap),
            WordCard(wordPair: pair),
            SizedBox.square(dimension: gap),
            Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton.icon(
                  onPressed: appState.toggleFavorite,
                  icon: Icon(
                    iconFavorite,
                    color: Colors.pink,
                    size: 16.0,
                    semanticLabel: 'Mark the generate word as favorite',
                  ),
                  label: Text('Favorite'),
                ),
                ElevatedButton.icon(
                  onPressed: appState.getNextName,
                  icon: Icon(
                    Icons.cached_outlined,
                    size: 16.0,
                    semanticLabel: 'Mark the generate word as favorite',
                  ),
                  label: Text('Generate name'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
