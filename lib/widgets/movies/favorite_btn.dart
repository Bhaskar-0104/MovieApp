import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key, required this.movieMosdel});

  final Titles movieMosdel;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, FavoritesProvider favoritesProvider, child) {
        return IconButton(
          onPressed: () {
            favoritesProvider.addRemoveFromFavorites(movieMosdel);
          },
          icon: Icon(
            favoritesProvider.isFavorite(movieMosdel)
                ? MyAppIcons.favoriteRounded
                : MyAppIcons.favoriteOutlineRounded,
            color: favoritesProvider.isFavorite(movieMosdel)
                ? Colors.red
                : null,
            size: 20,
          ),
        );
      },
    );
  }
}
