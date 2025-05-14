import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  test('TMDB 인기 영화 요청 테스트', () async {
    final token = dotenv.env['TMDB_BEARER_TOKEN'];

    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?language=ko-KR&page=1',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    print(response.statusCode);
    print(response.body);

    expect(response.statusCode, 200);
  });
}
