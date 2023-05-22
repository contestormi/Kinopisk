import 'package:kinopoisk/models/kino.dart';

abstract class KinoState {
  const KinoState();
}

class KinoInitialState extends KinoState {
  const KinoInitialState();
}

class KinoLoadingState extends KinoState {
  final String message;

  const KinoLoadingState({
    required this.message,
  });
}

class KinoSuccessState extends KinoState {
  final List<KinoModel> kinos;

  const KinoSuccessState({
    required this.kinos,
  });
}

class KinoCachedState extends KinoState {
  final List<KinoModel> kinos;

  const KinoCachedState({
    required this.kinos,
  });
}

class KinoErrorState extends KinoState {
  final String error;

  const KinoErrorState({
    required this.error,
  });
}
