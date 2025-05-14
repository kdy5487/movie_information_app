import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_information_app/data/data_sourece/moive_data_soure_impl.dart';
import 'package:movie_information_app/data/repository/movie_repository_impl.dart';
import 'package:movie_information_app/presentation/pages/home_page/home_page.dart';
import 'package:movie_information_app/presentation/pages/home_page/home_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final dataSource = MovieDataSourceImpl();
  final repository = MovieRepositoryImpl(dataSource: dataSource);
  // API 키 정상 로드 확인용
  log('API KEY: ${dotenv.env['TMDB_API_KEY']}');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repository)..fetchAll(), // 앱 시작 시 데이터 로딩
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
