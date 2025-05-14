// domain/repository/movie_repository.dart
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

abstract interface class MovieRepository {
  Future<List<Movie>?> fetchNowPlayingMovies();
  Future<List<Movie>?> fetchPopularMovies();
  Future<List<Movie>?> fetchTopRatedMovies();
  Future<List<Movie>?> fetchUpcomingMovies();
  Future<MovieDetail?> fetchMovieDetail(int id);
}
