import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/screens/favorites_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

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
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) {
              return IconButton(
                onPressed: () async {
                  themeProvider.toogleTheme();
                },
                icon: Icon(
                  themeProvider.themeData == MyThemeData.darkTheme
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, MoviesProvider movieProvider, child) {
          if (movieProvider.isLoading && movieProvider.movieList.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (movieProvider.fetchMoviesError.isNotEmpty) {
            return Center(child: Text(movieProvider.fetchMoviesError));
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent &&
                  !movieProvider.isLoading &&
                  movieProvider.hasMore) {
                movieProvider.getMovies();
                return true;
              }
              return false;
            },
            child: ListView.builder(
              itemCount:
                  movieProvider.movieList.length +
                  (movieProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < movieProvider.movieList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChangeNotifierProvider.value(
                      value: movieProvider.movieList[index],
                      child: MoviesWidget(),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
