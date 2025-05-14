import 'package:flutter/material.dart';
import 'package:movie_information_app/data/data_sourece/moive_data_soure_impl.dart';
import 'package:movie_information_app/data/repository/movie_repository.dart';
import 'package:movie_information_app/presentation/pages/detail_page/detail.dart';
import 'package:provider/provider.dart';
import 'package:movie_information_app/presentation/pages/detail_page/detail_view_model.dart';
import 'package:movie_information_app/domain/entity/movie_entity.dart';
import 'package:movie_information_app/presentation/pages/home_page/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: viewModel.fetchAll(),
        builder: (context, snapshot) {
          if (viewModel.nowPlaying == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            // 스크롤 뷰
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 가장 인기 있는 영화
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '가장 인기있는',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          final movie = viewModel.popular!.first;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ChangeNotifierProvider(
                                    create:
                                        (_) => DetailViewModel(
                                          MovieRepositoryImpl(
                                            dataSource: MovieDataSourceImpl(),
                                          ),
                                        ),
                                    child: DetailPage(
                                      movieId: movie.id,
                                      posterPath: movie.posterPath,
                                      heroTag:
                                          'featured_${movie.id}', // 대표 영화용 tag
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Hero(
                          tag:
                              'featured_${viewModel.popular!.first.id}', // 대표 영화는 featured_ prefix 사용
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${viewModel.popular!.first.posterPath}',
                              height: 400,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 분류별 섹션 (가로 스크롤)
                buildMovieSection("현재 상영중", viewModel.nowPlaying!),
                buildMovieSection("인기순", viewModel.popular!, showRanking: true),
                buildMovieSection("평점 높은 순", viewModel.topRated!),
                buildMovieSection("개봉 예정", viewModel.upcoming!),
              ],
            ),
          );
        },
      ),
    );
  }

  ///가로 스크롤 뷰는 위젯으로 분리해서 사용
  Widget buildMovieSection(
    String title,
    List<Movie> movies, {
    bool showRanking = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final tag =
                  '${title}_${movie.id}'; // 카테고리마다 tag에 prefix 부여하여 중복 방지

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ChangeNotifierProvider(
                            create:
                                (_) => DetailViewModel(
                                  MovieRepositoryImpl(
                                    dataSource: MovieDataSourceImpl(),
                                  ),
                                ),
                            child: DetailPage(
                              movieId: movie.id,
                              posterPath: movie.posterPath,
                              heroTag: tag, // 섹션별 tag 전달
                            ),
                          ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Hero(
                      tag: tag, // tag가 고유해야 Hero가 충돌 없이 동작함
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (showRanking)
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
