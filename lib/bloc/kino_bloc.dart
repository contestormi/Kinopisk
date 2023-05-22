import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinopoisk/bloc/kino_event.dart';
import 'package:kinopoisk/bloc/kino_state.dart';
import 'package:kinopoisk/datasources/kinopoisk_remote_data.dart';
import 'package:kinopoisk/models/doc.dart';

class KinoBloc extends Bloc<KinoEvent, KinoState> {
  final KinopoiskRemoteData kinoRepository;
  int page = 1;
  bool isFetching = false;

  KinoBloc({required this.kinoRepository}) : super(const KinoInitialState()) {
    on<KinoFetchEvent>(_onFetch);
  }

  void _onFetch(
    KinoFetchEvent event,
    Emitter<KinoState> emit,
  ) async {
    try {
      emit(const KinoLoadingState(message: 'Loading kinos'));
      final response = await kinoRepository.getKino(
        page: page,
        query: event.query,
      );
      var docs = DocModel.fromMap(response.data).docs ?? [];

      if (response.statusCode == 200) {
        emit(KinoSuccessState(kinos: docs));
        page++;
      } else {
        if (docs.isEmpty) {
          emit(KinoErrorState(error: response.data));
        } else {
          emit(KinoCachedState(kinos: docs));
        }
      }
    } catch (e) {
      emit(KinoErrorState(error: e.toString()));
    }
  }
}
