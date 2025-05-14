import 'package:flutter/material.dart';
import 'package:movie_information_app/presentation/pages/detail_page/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final int movieId;

  const DetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('영화 상세')),
      body: FutureBuilder(
        future: viewModel.fetchMovieDetail(movieId),
        builder: (context, snapshot) {
          final detail = viewModel.movieDetail;
          if (detail == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('장르: ${detail.genres.join(', ')}'),
                Text('런타임: ${detail.runtime}분'),
                Text('개봉일: ${detail.releaseDate.toLocal()}'),
                const SizedBox(height: 16),
                Text(
                  '줄거리',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(detail.overview),
              ],
            ),
          );
        },
      ),
    );
  }
}
