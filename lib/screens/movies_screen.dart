import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/favorites_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<Titles> _movies = [];
  bool _isFetching = false;
  String types = 'MOVIE';
  String sortBy = 'SORT_BY_POPULARITY';
  String pageToken = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isFetching) return;
    setState(() {
      _isFetching = true;
    });

    try {
      final MoviesModel movieModel = await getIt<MoviesRepo>().fetchMovies(
        types: types,
        sortBy: sortBy,
        pageToken: pageToken,
      );
      setState(() {
        _movies.addAll(movieModel.titles ?? []);
        pageToken = movieModel.nextPageToken ?? '';
      });
    } catch (error) {
      getIt<NavigationService>().showSnackbar(
        'An error has been occured $error',
      );
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: Icon(MyAppIcons.favoriteRounded, color: Colors.red),
          ),
          IconButton(
            onPressed: () async {
              // final List<Titles> movies = await getIt<ApiService>().fetchMovies();
              // final List<Titles> movies = await getIt<MoviesRepo>()
              //     .fetchMovies();
              // log("movies $movies");
            },
            icon: Icon(MyAppIcons.darkMode),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _movies.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MoviesWidget(movieModel: _movies[index]),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
