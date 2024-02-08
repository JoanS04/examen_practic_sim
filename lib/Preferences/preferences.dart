import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _prefs;

  static String _nomUsuari = '';
  static String _contrassenya = '';

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  

  static String get nomUsuari{
    return _prefs.getString('nomUsuari') ?? _nomUsuari;
  }

  static set nomUsuari(String value){
    _nomUsuari = value;
    _prefs.setString('nomUsuari', nomUsuari);
  }

  static String get contrassenya{
    return _prefs.getString('contrassenya') ?? _contrassenya;
  }

  static set contrassenya(String value){
    _contrassenya = value;
    _prefs.setString('contrassenya', contrassenya);
  }
}