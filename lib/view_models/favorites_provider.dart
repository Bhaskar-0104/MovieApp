import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Titles> _favoritesList = [];
  List<Titles> get favoritesList => _favoritesList;
  final favsKey = "favKey";

  bool isFavorite(Titles movie) {
    return _favoritesList.any((data) => data.id == movie.id);
  }

  Future<void> addRemoveFromFavorites(Titles movie) async {
    if (isFavorite(movie)) {
      _favoritesList.removeWhere((data) => data.id == movie.id);
    } else {
      _favoritesList.add(movie);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = _favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    pref.setStringList(favsKey, stringList);
  }

  Future<void> loadFavorites() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = pref.getStringList(favsKey) ?? [];
    _favoritesList.clear();
    _favoritesList.addAll(stringList.map((e) => Titles.fromJson(json.decode(e)),));
    notifyListeners();
  }

  void clearAllFavs() {
    _favoritesList.clear();
    notifyListeners();
    saveFavorites();
  }
}
