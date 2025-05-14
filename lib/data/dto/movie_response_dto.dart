import 'package:movie_information_app/data/dto/movie_dto.dart';

///TMDB API의 전체 항목을 포함하는 응답 구조
class MovieResponseDto {
  final int page;
  final List<MovieDto> results;
  final int totalPages;
  final int totalResults;

  MovieResponseDto({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      page: json['page'],
      results:
          (json['results'] as List)
              .map((item) => MovieDto.fromJson(item))
              .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
