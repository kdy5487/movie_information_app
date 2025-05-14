import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

/// 영화 데이터를 가져오는 데 필요한 기능을 정의한 도메인 계층의 인터페이스
abstract interface class MovieRepository {
  Future<List<Movie>?> fetchNowPlayingMovies();
  Future<List<Movie>?> fetchPopularMovies();
  Future<List<Movie>?> fetchTopRatedMovies();
  Future<List<Movie>?> fetchUpcomingMovies();

  Future<MovieDetail?> fetchMovieDetail(int id);
}
