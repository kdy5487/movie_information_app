import 'package:flutter/material.dart';
import 'package:movie_information_app/domain/entity/movie_detail_entity.dart';
import 'package:movie_information_app/domain/repository/movie_repository.dart';

// 상세 화면의 상태를 관리하는 ViewModel
class DetailViewModel extends ChangeNotifier {
  final MovieRepository _repository;

  DetailViewModel(this._repository);

  MovieDetail? movieDetail; // 현재 상세 정보 상태

  // 영화 상세 정보를 비동기로 가져오고 상태 갱신
  Future<void> fetchMovieDetail(int id) async {
    movieDetail = await _repository.fetchMovieDetail(id);
    notifyListeners();
  }
}
