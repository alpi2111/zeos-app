import 'dart:convert';

import 'package:http/http.dart' as http;

class EntradaSalidaProvider {
  static final _url = "https://zeos-app.firebaseio.com";
  final _urlDisponible = '$_url/herramientas.json?orderBy="disponible"&equalTo';

  //true es para las que se pueden prestar
  //false es para las que estan prestadas
  Future<List<String>> obtenerEnAlmacen() async {
    final url = '$_urlDisponible=true';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    List<String> lista = List<String>();

    //decodedResp
    if (decodedResp.isNotEmpty) {
      //print(decodedResp);
      decodedResp.forEach((key, val) {
        final String temp = val['id_herramienta'];
        lista.add(temp);
        //updateHerramientaDisponible(key, temp, false);
        //print(temp);
        //updateHerramientaDisponible(temp, false);
        //temp.disponible = false;
      });
      return lista;
    } else {
      return lista;
    }
  }

  Future<List<String>> obtenerFueraAlmacen() async {
    final url = '$_urlDisponible=false';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    List<String> lista = List<String>();

    //decodedResp
    if (decodedResp.isNotEmpty) {
      //print(decodedResp);
      decodedResp.forEach((key, val) {
        final String temp = val['id_herramienta'];
        lista.add(temp);
        //updateHerramientaDisponible(key, temp, true);
        //print(temp);
        //temp.disponible = false;
      });
      return lista;
    } else {
      return lista;
    }
  }

  Future updateHerramientaDisponible(String key, String id, bool dispo) async {
    final url = '$_url/herramientas/$key/.json';

    final resp = await http.patch(url, body: json.encode({"disponible": dispo}));

    final decodedResp = json.decode(resp.body);

    print(decodedResp);
  }
}
