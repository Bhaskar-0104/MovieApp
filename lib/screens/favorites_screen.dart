import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
        actions: [
          IconButton(
            onPressed: () {
              favoritesProvider.clearAllFavs();
            },
            icon: Icon(MyAppIcons.delete, color: Colors.red),
          ),
        ],
      ),
      body: favoritesProvider.favoritesList.isEmpty
          ? Center(
              child: Text(
                "No added Favs",
                style: TextStyle(fontSize: 30, fontWeight: .bold),
              ),
            )
          : ListView.builder(
              itemCount: favoritesProvider.favoritesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: favoritesProvider.favoritesList.reversed
                      .toList()[index],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MoviesWidget(),
                  ),
                );
              },
            ),
    );
  }
}
