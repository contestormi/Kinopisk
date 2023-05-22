import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kinopoisk/datasources/kinopoisk_remote_data.dart';
import 'package:kinopoisk/datasources/kinopoisk_remote_data_impl.dart';
import 'package:kinopoisk/screens/display.dart';
import 'package:kinopoisk/services/directory_service.dart';
import 'package:kinopoisk/services/directory_service_impl.dart';

import 'constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> setupDependencies() async {
  final DirectoryService dirService = DirectoryServiceImpl();

  final dio = Dio(
    BaseOptions(
      headers: {
        'X-API-KEY': Constants.token,
        'accept': 'application/json',
      },
    ),
  )..interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: FileCacheStore(await dirService.getTempPath()),
          policy: CachePolicy.forceCache,
          maxStale: const Duration(days: 7),
          priority: CachePriority.normal,
        ),
      ),
    );
  GetIt.I.registerSingleton<KinopoiskRemoteData>(
      KinopoiskRemoteDataImpl(dio: dio));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const KinopoiskApp());
}

class KinopoiskApp extends StatelessWidget {
  const KinopoiskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kino App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const DisplayKinoScreen(),
      },
    );
  }
}
