import 'package:dio/dio.dart';

abstract class KinopoiskRemoteData {
  Future<Response> getKino({
    required int page,
    required String query,
  });
}
