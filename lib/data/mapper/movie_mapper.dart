// data/mapper/movie_mapper.dart
import 'package:movie_information_app/data/dto/movie_detail.dto.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';

import '../dto/movie_response_dto.dart';

extension MovieResponseMapper on MovieResponseDto {
  List<Movie> toEntityList() =>
      results.map((e) => Movie(id: e.id, posterPath: e.posterPath)).toList();
}

extension MovieDetailMapper on MovieDetailDto {
  MovieDetail toEntity() => MovieDetail(
    budget: budget,
    genres: genres.map((e) => e.name).toList(),
    id: id,
    productionCompanyLogos:
        productionCompanies.map((e) => e.logoPath ?? "").toList(),
    overview: overview,
    popularity: popularity,
    releaseDate: DateTime.parse(releaseDate),
    revenue: revenue,
    runtime: runtime,
    tagline: tagline,
    title: title,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}
