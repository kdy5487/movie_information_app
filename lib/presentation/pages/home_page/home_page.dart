import 'package:flutter/material.dart';

/*
스크롤 뷰 
  Column
   인기 영화(텍스트 + 이미지)
   +
   Column (분류에 따라 4가지)
    텍스트 
    가로 방향 리스트뷰
*/

class HomePage extends StatelessWidget {
  /// API 연동 전 더미 이미지
  final dummyImage = 'https://picsum.photos/400/600';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //기본 다크모드

      body: SingleChildScrollView(
        // 스크롤 뷰
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 가장 인기있는 영화 - 큰 포스터
            Padding(
              padding: const EdgeInsets.all(20), //패딩 20 요구사항
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '가장 인기있는',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      dummyImage,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // 분류별 섹션 (가로 스크롤)
            buildMovieSection("현재 상영중"),
            buildMovieSection("인기순"),
            buildMovieSection("평점 높은 순"),
            buildMovieSection("개봉 예정"),
          ],
        ),
      ),
    );
  }

  ///가로 스크롤 뷰는 위젯으로 분리해서 사용
  Widget buildMovieSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 180, // 리스트 뷰 높이 180 요구사항
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20, //이미지 20개씩 출력 요구사항
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                padding: const EdgeInsets.all(8),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(dummyImage, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
