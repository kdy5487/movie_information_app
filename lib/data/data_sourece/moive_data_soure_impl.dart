import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_information_app/data/data_sourece/movie_data_source.dart';
import 'package:movie_information_app/data/dto/movie_detail.dto.dart';
import 'package:movie_information_app/data/dto/movie_response_dto.dart';

// 실제로 API 요청을 보내고 데이터를 받아오는 구현체
class MovieDataSourceImpl implements MovieDataSource {
  // TMDB API의 기본 URL
  static const _baseUrl = 'https://api.themoviedb.org/3';

  // 공통 GET 요청 함수 (endpoint와 JSON 파싱 함수를 받음)
  Future<T?> _get<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final token = dotenv.env['TMDB_API_KEY']; // .env에서 API 키 로드

    // API 요청 보내기
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'), // 입력받은 endpoint로 URL 구성
      headers: {
        'Authorization': 'Bearer $token', // 인증 헤더 (v4 토큰 방식)
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    // 응답 코드가 200(정상)일 경우, JSON 파싱 후 반환
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    }

    // 실패 시 null 반환
    return null;
  }

  /// 현재 상영 중인 영화 목록 가져오기
  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() =>
      _get('movie/now_playing', (json) => MovieResponseDto.fromJson(json));

  /// 인기 영화 목록 가져오기
  @override
  Future<MovieResponseDto?> fetchPopularMovies() =>
      _get('movie/popular', (json) => MovieResponseDto.fromJson(json));

  /// 평점 높은 영화 목록 가져오기
  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() =>
      _get('movie/top_rated', (json) => MovieResponseDto.fromJson(json));

  /// 개봉 예정 영화 목록 가져오기
  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() =>
      _get('movie/upcoming', (json) => MovieResponseDto.fromJson(json));

  /// 특정 영화의 상세 정보 가져오기
  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) =>
      _get('movie/$id', (json) => MovieDetailDto.fromJson(json));
}
