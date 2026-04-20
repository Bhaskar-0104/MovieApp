import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/service/api_service.dart';

class MoviesRepo {
  MoviesRepo(this._apiService);
  final ApiService _apiService;

  Future<MoviesModel> fetchMovies({
    String types = 'MOVIE',
    String sortBy = 'SORT_BY_POPULARITY',
    String pageToken = '',
  }) async {
    return await _apiService.fetchMovies(
      types: types,
      sortBy: sortBy,
      pageToken: pageToken,
    );
  }
}
