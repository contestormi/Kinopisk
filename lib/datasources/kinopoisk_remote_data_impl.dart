import 'package:dio/dio.dart';
import 'package:kinopoisk/constants.dart';
import 'package:kinopoisk/datasources/kinopoisk_remote_data.dart';

class KinopoiskRemoteDataImpl implements KinopoiskRemoteData {
  static const int _perPage = 10;

  final Dio dio;

  KinopoiskRemoteDataImpl({required this.dio});

  @override
  Future<Response> getKino({
    required int page,
    required String query,
  }) async {
    try {
      return await dio.get(
          '${Constants.baseUrl}/v1.2/movie/search?page=$page&limit=$_perPage&query=$query');
    } catch (e) {
      rethrow;
    }
  }
}
