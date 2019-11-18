import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del usuario
  get usuario {
    return _prefs.getString('usuario') ?? '';
  }

  set usuario(String value) {
    _prefs.setString('usuario', value);
  }

  get token {
    return _prefs.getString('token') ?? null;
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  get isAdmin {
    return _prefs.getBool('isAdmin') ?? false;
  }

  set isAdmin(bool value) {
    _prefs.setBool('isAdmin', value);
  }

  get sucursal {
    return _prefs.getString('sucursal') ?? null;
  }

  set sucursal(String sucursal) {
    _prefs.setString('sucursal', sucursal);
  }

  get encargado {
    return _prefs.getString('encargado') ?? null;
  }

  set encargado(String encargado) {
    _prefs.setString('encargado', encargado);
  }
}
