import 'dart:convert';

import 'package:constructor_rajuma/src/models/herramienta_model.dart';
import 'package:http/http.dart' as http;

class EntradaSalidaProvider {
  static final _url = "https://zeos-app.firebaseio.com";
  final _urlDisponible = '$_url/herramientas.json?orderBy="disponible"&equalTo';

  //true es para las que se pueden prestar
  //false es para las que estan prestadas
  Future<List<HerramientaModel>> obtenerEnAlmacen() async {
    final url = '$_urlDisponible=true';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    List<HerramientaModel> lista = List<HerramientaModel>();

    //decodedResp
    if (decodedResp.isNotEmpty) {
      //print(decodedResp);
      decodedResp.forEach((key, val) {
        final HerramientaModel temp = HerramientaModel();
        temp.idHerramienta = val['id_herramienta'];
        temp.nombre = val['nombre'];
        temp.idSucursal = val['id_sucursal'];
        temp.disponible = val['disponible'];
        temp.idFb = key;
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

  Future<List<HerramientaModel>> obtenerFueraAlmacen() async {
    final url = '$_urlDisponible=false';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    List<HerramientaModel> lista = List<HerramientaModel>();

    //decodedResp
    if (decodedResp.isNotEmpty) {
      //print(decodedResp);
      decodedResp.forEach((key, val) {
        final HerramientaModel temp = HerramientaModel();
        temp.idHerramienta = val['id_herramienta'];
        temp.nombre = val['nombre'];
        temp.idSucursal = val['id_sucursal'];
        temp.disponible = val['disponible'];
        temp.idFb = key;
        //val['id_herramienta'];
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

    final resp =
        await http.patch(url, body: json.encode({"disponible": dispo}));

    final decodedResp = json.decode(resp.body);

    print(decodedResp);
  }

  Future<bool> updateStateHerramienta(String id, bool state, {String empleado}) async {
    final url = '$_url/herramientas/$id/.json';

    final response =
        await http.patch(url, body: json.encode({"disponible": state, "empleado" : empleado}));

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    if (decodedResp.containsKey('disponible'))
      return true;
    else
      return false;
  }
}
