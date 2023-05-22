import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kinopoisk/bloc/kino_bloc.dart';
import 'package:kinopoisk/datasources/kinopoisk_remote_data.dart';
import 'package:kinopoisk/screens/body.dart';

class DisplayKinoScreen extends StatelessWidget {
  const DisplayKinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KinoBloc(
        kinoRepository: GetIt.I<KinopoiskRemoteData>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kinopoisk 🎞️'),
        ),
        body: const KinoBody(),
      ),
    );
  }
}
