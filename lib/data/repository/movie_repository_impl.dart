import 'package:movie_information_app/data/data_sourece/movie_data_source.dart';
import 'package:movie_information_app/data/mapper/movie_mapper.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

import '../../domain/repository/movie_repository.dart';

// MovieRepository 인터페이스의 실제 구현체
class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  // 현재 상영 중인 영화 목록 조회
  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final dto = await dataSource.fetchNowPlayingMovies();
    return dto?.toEntityList(); // DTO → Entity 변환
  }

  // 인기 영화 목록 조회
  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final dto = await dataSource.fetchPopularMovies();
    return dto?.toEntityList();
  }

  // 평점 높은 영화 목록 조회
  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final dto = await dataSource.fetchTopRatedMovies();
    return dto?.toEntityList();
  }

  // 개봉 예정 영화 목록 조회
  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final dto = await dataSource.fetchUpcomingMovies();
    return dto?.toEntityList();
  }

  // 영화 상세 정보 조회
  @override
  Future<MovieDetail?> fetchMovieDetail(int id) async {
    final dto = await dataSource.fetchMovieDetail(id);
    return dto?.toEntity(); // DTO → Entity 변환
  }
}
