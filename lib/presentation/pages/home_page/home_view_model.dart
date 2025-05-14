import 'package:flutter/material.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';
import 'package:movie_information_app/domain/repository/movie_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepository _repository;

  HomeViewModel(this._repository);

  List<Movie>? nowPlaying;
  List<Movie>? popular;
  List<Movie>? topRated;
  List<Movie>? upcoming;

  Future<void> fetchAll() async {
    nowPlaying = await _repository.fetchNowPlayingMovies();
    popular = await _repository.fetchPopularMovies();
    topRated = await _repository.fetchTopRatedMovies();
    upcoming = await _repository.fetchUpcomingMovies();
    notifyListeners();
  }
}
