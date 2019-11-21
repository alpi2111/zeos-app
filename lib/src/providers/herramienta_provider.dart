import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/models/herramienta_model.dart';

class HerramientaProvider {
  final _url = "https://zeos-app.firebaseio.com";

  Future<List<HerramientaModel>> obtenerTodasHerramientasSucursal(
      String idSucursal) async {
    final url =
        '$_url/herramientas.json?orderBy="id_sucursal"&equalTo="$idSucursal"';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);
    final List<HerramientaModel> lista = new List<HerramientaModel>();

    if (decodedResp.isEmpty) {
      return [];
    }
    //if (decodedResp.containsKey('id_sucursal')) {
    decodedResp.forEach((key, val) {
      final temp = HerramientaModel();
      temp.disponible = val['disponible'];
      temp.idHerramienta = val['id_herramienta'];
      temp.idSucursal = val['id_sucursal'];
      temp.nombre = val['nombre'];
      temp.idFb = key;
      lista.add(temp);
    });
    return lista;
    /*} else {
      return [];
    }*/
  }

  Future<bool> agregarHerramienta(HerramientaModel model) async {
    final url = "$_url/herramientas.json";

    final response = await http.post(url, body: herramientaModelToJson(model));

    final decodedResp = json.decode(response.body);

    if (decodedResp != null)
      return true;
    else
      return false;
    //print(decodedResp);
  }

  Future<bool> eliminarHerramienta(String id) async {
    final url = "$_url/herramientas/$id.json";

    final response = await http.delete(url);

    final decodedResp = json.decode(response.body);

    if (decodedResp == null)
      return true;
    else
      return false;
  }
}
