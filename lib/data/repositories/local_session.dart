class LocalSession{

  static final LocalSession _localSession = LocalSession._internal();

  factory LocalSession(){
    return _localSession;
  }

  LocalSession._internal();

  String? currentLocation;
}