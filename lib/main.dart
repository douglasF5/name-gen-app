import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import './home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'NameGen',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // Get and set current word pair
  var current = WordPair.random();

  getNextName() {
    current = WordPair.random();
    notifyListeners();
  }

  // Get and set favorites
  var favoritesList = <WordPair>[];

  toggleFavorite() {
    if (favoritesList.contains(current)) {
      favoritesList.remove(current);
    } else {
      favoritesList.add(current);
    }
    notifyListeners();
  }
}
