import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm_statemanagements/constants/api_constants.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class ApiService {
  Future<MoviesModel> fetchMovies({
    String types = 'MOVIE',
    String sortBy = 'SORT_BY_POPULARITY',
    String pageToken = '',
  }) async {
    late Uri url;
    if (pageToken.isEmpty) {
      url = Uri.parse(
        "${ApiConstants.baseUrl}/titles?types=$types&sortBy=$sortBy",
      );
    } else {
      url = Uri.parse(
        "${ApiConstants.baseUrl}/titles?types=$types&sortBy=$sortBy&pageToken=$pageToken",
      );
    }
    final response = await http.get(url, headers: ApiConstants.headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MoviesModel.fromJson(data);
    } else {
      throw Exception("Failed to load movies: ${response.statusCode}");
    }
  }
}
