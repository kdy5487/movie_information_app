// data/repository/movie_repository_impl.dart
import 'package:movie_information_app/data/data_sourece/movie_data_source.dart';
import 'package:movie_information_app/data/mapper/movie_mapper.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

import '../../domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final dto = await dataSource.fetchNowPlayingMovies();
    return dto?.toEntityList();
  }

  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final dto = await dataSource.fetchPopularMovies();
    return dto?.toEntityList();
  }

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final dto = await dataSource.fetchTopRatedMovies();
    return dto?.toEntityList();
  }

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final dto = await dataSource.fetchUpcomingMovies();
    return dto?.toEntityList();
  }

  @override
  Future<MovieDetail?> fetchMovieDetail(int id) async {
    final dto = await dataSource.fetchMovieDetail(id);
    return dto?.toEntity();
  }
}
