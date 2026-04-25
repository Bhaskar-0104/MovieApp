import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';

class MoviesProvider with ChangeNotifier {
  final String _types = 'MOVIE';
  final String _sortBy = 'SORT_BY_POPULARITY';
  String _pageToken = '';
  final List<Titles> _movieList = [];
  List<Titles> get movieList => _movieList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Guard: prevents duplicate concurrent calls
  bool _isFetching = false;

  // Stops pagination when there's no next page token
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepo _moviesRepo = getIt<MoviesRepo>();

  Future<void> getMovies() async {
    // Prevent duplicate calls and stop if no more pages
    if (_isFetching || !_hasMore) return;

    _isFetching = true;
    _isLoading = true;
    notifyListeners();
    try {
      MoviesModel movieResponse = await _moviesRepo.fetchMovies(
        types: _types,
        sortBy: _sortBy,
        pageToken: _pageToken,
      );
      List<Titles> movies = movieResponse.titles ?? [];
      _pageToken = movieResponse.nextPageToken ?? '';

      // If no next page token returned, we've reached the end
      if (_pageToken.isEmpty) {
        _hasMore = false;
      }

      _movieList.addAll(movies);
      _fetchMoviesError = "";
    } catch (error) {
      log("An error occured in fetch movies $error");
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isFetching = false;
      _isLoading = false;
      notifyListeners();
    }
  }
}
