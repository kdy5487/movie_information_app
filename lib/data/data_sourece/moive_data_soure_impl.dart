// data/datasource/movie_data_source_impl.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_information_app/%08core/env.dart';
import 'package:movie_information_app/data/dto/movie_detail.dto.dart';
import '../dto/movie_response_dto.dart';
import 'movie_data_source.dart';

class MovieDataSourceImpl implements MovieDataSource {
  static const _baseUrl = 'https://api.themoviedb.org/3';

  Future<T?> _get<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final token = dotenv.env['TMDB_API_KEY']; //v4
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );
    //무한로딩 원인 찾기
    print('응답 코드: ${response.statusCode}');
    print('응답 내용: ${response.body}');

    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    }
    return null;
  }

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() =>
      _get('movie/now_playing', (json) => MovieResponseDto.fromJson(json));

  @override
  Future<MovieResponseDto?> fetchPopularMovies() =>
      _get('movie/popular', (json) => MovieResponseDto.fromJson(json));

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() =>
      _get('movie/top_rated', (json) => MovieResponseDto.fromJson(json));

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() =>
      _get('movie/upcoming', (json) => MovieResponseDto.fromJson(json));

  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) =>
      _get('movie/$id', (json) => MovieDetailDto.fromJson(json));
}
