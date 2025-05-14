import 'package:movie_information_app/data/dto/movie_detail.dto.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

import '../dto/movie_response_dto.dart';

//DTO → 도메인 엔터티

// MovieResponseDto → List<Movie> 로 변환
extension MovieResponseMapper on MovieResponseDto {
  List<Movie> toEntityList() =>
      results.map((e) => Movie(id: e.id, posterPath: e.posterPath)).toList();
}

// MovieDetailDto → MovieDetail 로 변환
extension MovieDetailMapper on MovieDetailDto {
  MovieDetail toEntity() => MovieDetail(
    budget: budget,
    genres: genres.map((e) => e.name).toList(), // 장르 이름만 추출
    id: id,
    productionCompanyLogos:
        productionCompanies.map((e) => e.logoPath ?? "").toList(), // 로고 경로 리스트
    overview: overview,
    popularity: popularity,
    releaseDate: DateTime.parse(releaseDate), // 문자열 → DateTime 변환
    revenue: revenue,
    runtime: runtime,
    tagline: tagline,
    title: title,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}
