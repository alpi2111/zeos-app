import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/preferences/preferencias_usuario.dart';

class LoginProvider {
  final _firebaseToken = 'AIzaSyDnmxHyzBkl8ODKAEsFn9XhoGDev3_cars';
  final _prefs = new PreferenciasUsuario();
  final _correoAdmin = 'supervisor_matriz@rajuma.com';

  //final String _url = "https://zeos-app.firebaseio.com";

  Future<Map<String, dynamic>> iniciarSesion(String usuario, String pass) async {
    final authData = {
      'email': usuario,
      'password': pass,
      'returnSecureToken': true
    };

    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';

    try {
      
      final resp = await http.post(url, body: json.encode(authData));

      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      //print(decodedResp);

      if (decodedResp.containsKey('idToken')) {
        _prefs.token = decodedResp['idToken'];
        _prefs.usuario = decodedResp['email'];
        if (decodedResp['email'] == _correoAdmin) {
          //_prefs.sucursal = 'matriz'; //TODO ver si esta propiedad sirve
          _prefs.isAdmin = true;
        } else {
          _prefs.isAdmin = false;
        }
        //_prefs.usuario;
        return {'ok': true, 'token': decodedResp['idToken']};
      } else {
        return {'ok': false, 'mensaje': decodedResp['error']['message']};
      }

    } catch (e) {
      //print(e);
      return {'ok':false, 'mensaje': 'Failed $e'};
    }
  }
}
