import 'package:flutter/material.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/repository/movie_repository.dart';

class DetailViewModel extends ChangeNotifier {
  final MovieRepository _repository;

  DetailViewModel(this._repository);

  MovieDetail? movieDetail;

  Future<void> fetchMovieDetail(int id) async {
    movieDetail = await _repository.fetchMovieDetail(id);
    notifyListeners();
  }
}
