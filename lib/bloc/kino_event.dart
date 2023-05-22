abstract class KinoEvent {
  const KinoEvent();
}

class KinoFetchEvent extends KinoEvent {
  final String query;

  const KinoFetchEvent(this.query);
}
