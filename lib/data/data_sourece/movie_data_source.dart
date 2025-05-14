import 'package:movie_information_app/data/dto/movie_detail.dto.dart';
import '../dto/movie_response_dto.dart';

///추상 인터페이스를 정의, 실제 구현은 MovieDataSourceImpl에서 수행
abstract interface class MovieDataSource {
  /// 현재 상영 중 영화 목록 요청
  Future<MovieResponseDto?> fetchNowPlayingMovies();

  /// 인기 영화 목록 요청
  Future<MovieResponseDto?> fetchPopularMovies();

  /// 평점 높은 영화 목록 요청
  Future<MovieResponseDto?> fetchTopRatedMovies();

  /// 개봉 예정 영화 목록 요청
  Future<MovieResponseDto?> fetchUpcomingMovies();

  /// 특정 영화의 상세 정보 요청
  Future<MovieDetailDto?> fetchMovieDetail(int id);
}
