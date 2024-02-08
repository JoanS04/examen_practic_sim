import 'package:flutter/foundation.dart';

class LocalUserProvider with ChangeNotifier {

  String _nomUsuari = '';
  String _contrassenya = '';

  LocalUserProvider(this._nomUsuari, this._contrassenya);

  String get nomUsuari => _nomUsuari;
  String get contrassenya => _contrassenya;

  set nomUsuari(String value) {
    _nomUsuari = value;
    notifyListeners();
  }

  set contrassenya(String value) {
    _contrassenya = value;
    notifyListeners();
  }
}