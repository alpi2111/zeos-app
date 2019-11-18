
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/models/herramienta_model.dart';

class HerramientaProvider {

  final _url = "https://zeos-app.firebaseio.com";

  Future<String> obtenerHerramientasSucursal(String idSucursal) async {
    final url = '$_url/herramientas.json';
    return url;
  }

  Future<bool> agregarHerramienta(HerramientaModel model) async {
    final url = "$_url/herramientas.json";

    final response = await http.post(url, body: herramientaModelToJson(model));

    final decodedResp = json.decode(response.body);
    
    if(decodedResp != null) return true;
    else return false;
    //print(decodedResp);
  }
  
}