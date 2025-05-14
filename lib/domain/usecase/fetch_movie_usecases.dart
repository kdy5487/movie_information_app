// domain/usecase/fetch_movie_usecases.dart
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

import '../repository/movie_repository.dart';

class FetchMovieUseCases {
  final MovieRepository repository;

  FetchMovieUseCases({required this.repository});

  Future<List<Movie>?> getNowPlaying() => repository.fetchNowPlayingMovies();
  Future<List<Movie>?> getPopular() => repository.fetchPopularMovies();
  Future<List<Movie>?> getTopRated() => repository.fetchTopRatedMovies();
  Future<List<Movie>?> getUpcoming() => repository.fetchUpcomingMovies();
  Future<MovieDetail?> getDetail(int id) => repository.fetchMovieDetail(id);
}
