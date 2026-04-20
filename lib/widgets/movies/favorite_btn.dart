import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class FavoriteBtnWidget extends StatefulWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});

  final Titles movieModel;

  @override
  State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
}

class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
  final favoritesMovieIds = [];

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoritesMovieIds.contains(widget.movieModel.id);
    return IconButton(
      onPressed: () {
        setState(() {
          if (isFavorite) {
            favoritesMovieIds.remove(widget.movieModel.id);
          } else {
            favoritesMovieIds.add(widget.movieModel.id);
          }
        });
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
