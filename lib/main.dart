import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_information_app/data/data_sourece/moive_data_soure_impl.dart';
import 'package:movie_information_app/data/repository/movie_repository.dart';
import 'package:movie_information_app/presentation/pages/home_page/home_page.dart';
import 'package:movie_information_app/presentation/pages/home_page/home_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final dataSource = MovieDataSourceImpl();
  final repository = MovieRepositoryImpl(dataSource: dataSource);
  print('API KEY: ${dotenv.env['TMDB_API_KEY']}');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repository)..fetchAll(),
        ),
        // 필요시 DetailViewModel도 Provider로 추가 가능
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
