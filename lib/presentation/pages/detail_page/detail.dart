import 'package:flutter/material.dart';
import 'package:movie_information_app/presentation/pages/detail_page/detail_view_model.dart';
import 'package:provider/provider.dart';

//상세 정보
class DetailPage extends StatelessWidget {
  final int movieId; // 영화 ID
  final String posterPath; // 포스터 경로
  final String heroTag; // Hero 고유 tag

  const DetailPage({
    super.key,
    required this.movieId,
    required this.posterPath,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Hero 위젯은 반드시 화면 진입 시점에 렌더되어 있어야 함
          Hero(
            tag: heroTag, // HomePage에서 넘겨받은 고유 tag를 사용
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$posterPath',
                height: 600,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[900],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder:
                    (_, __, ___) => Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.red),
                      ),
                    ),
              ),
            ),
          ),
          // 상세 정보 로딩 및 표시 영역
          Expanded(
            child: FutureBuilder(
              future: viewModel.fetchMovieDetail(movieId),
              builder: (context, snapshot) {
                final detail = viewModel.movieDetail;

                if (detail == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                // 상세 내용 렌더링
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '장르: ${detail.genres.join(', ')}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '런타임: ${detail.runtime}분',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '개봉일: ${detail.releaseDate.toLocal()}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '줄거리',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        detail.overview,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
