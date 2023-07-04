import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'generate_name_card.dart';
import 'favorite_name_card.dart';

// Main function
void main() {
  runApp(App());
}

// App setup
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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

// App state
class AppState extends ChangeNotifier {
  // Get and set current word pair
  var current = WordPair.random();

  getNextName() {
    current = WordPair.random();
    notifyListeners();
  }

  // Get and set favorites
  var favoritesSet = <WordPair>{};

  toggleCurrentFavorite() {
    if (favoritesSet.contains(current)) {
      favoritesSet.remove(current);
    } else {
      favoritesSet.add(current);
    }
    notifyListeners();
  }

  removeFavorite(WordPair wordPair) {
    final toBeRemoved = favoritesSet.firstWhere(
      (element) {
        print('removing word...');
        return element == wordPair;
      },
    );

    favoritesSet.remove(toBeRemoved);
    notifyListeners();
  }

  removeAllFavorites() {
    favoritesSet = {};
    notifyListeners();
  }
}

// Home page
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

// Home page state
class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GenerateTabContent();
        break;
      case 1:
        page = FavoritesTabContent();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: constraints.maxWidth >= 700.0,
              minExtendedWidth: 200.0,
              leading: SizedBox.square(
                dimension: 8.0,
              ),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.cached_outlined),
                  label: Text(
                    'Generate',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              color: Theme.of(context).colorScheme.surfaceTint.withAlpha(20),
              child: Align(
                alignment: Alignment.center,
                child: page,
              ),
            ),
          )
        ],
      ));
    });
  }
}

// Tab panels
class GenerateTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var wordPair = appState.current;
    double gap = 16.0;

    IconData iconFavorite;
    if (appState.favoritesSet.contains(wordPair)) {
      iconFavorite = Icons.favorite;
    } else {
      iconFavorite = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GenerateNameCard(wordPair: wordPair),
          SizedBox.square(dimension: gap),
          Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              ElevatedButton.icon(
                onPressed: appState.toggleCurrentFavorite,
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
                  semanticLabel: 'Generate a new name',
                ),
                label: Text('Generate name'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FavoritesTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);

    //Page title
    String pageTitle;
    switch (appState.favoritesSet.length) {
      case 0:
        pageTitle = 'No favorites';
        break;
      case 1:
        pageTitle = '1 favorite';
        break;
      default:
        pageTitle = '${appState.favoritesSet.length} favorites';
    }

    Widget pageTitleArea = Align(
      alignment: Alignment.topLeft,
      child: Text(
        pageTitle,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // Tab empty state
    Widget tabEmptyState = Column(
      children: [
        pageTitleArea,
        Expanded(
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 48.0,
                  color: theme.colorScheme.onSurface.withOpacity(0.24),
                ),
                Text('No favorite names.',
                    style: TextStyle(
                        color: theme.colorScheme.onSurface.withOpacity(0.65))),
              ],
            ),
          ),
        ),
      ],
    );

    // Tab content
    Widget tabContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pageTitleArea,
        SizedBox.square(dimension: 16.0),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            ...appState.favoritesSet
                .map((wordPair) =>
                    FavoriteNameCard(wordPair, appState.removeFavorite))
                .toList(),
          ],
        ),
      ],
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 800.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: appState.favoritesSet.isNotEmpty ? tabContent : tabEmptyState,
      ),
    );
  }
}
