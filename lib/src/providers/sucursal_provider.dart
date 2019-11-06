import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/models/sucursal_model.dart';

class SucursalProvider {
  //final _firebaseToken = 'AIzaSyDnmxHyzBkl8ODKAEsFn9XhoGDev3_cars';
  final String _url = "https://zeos-app.firebaseio.com";

  Future<List<SucursalModel>> cargarSucursales() async {
    final url = "$_url/sucursales.json";
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<SucursalModel> sucursales = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, nombre) {
      final sucTemp = SucursalModel.fromJson(nombre);
      sucTemp.idSucursal = id;
      sucursales.add(sucTemp);
    });
    return sucursales;
  }

  Future<bool> agregarSucursal(SucursalModel model) async {
    final url = '$_url/sucursales/${model.idSucursal}.json';

    final response =
        await http.put(url, body: sucursalModelToJsonNoFull(model));

    final decodedResp = json.decode(response.body);

    //print(decodedResp);
    if (decodedResp != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> eliminarSucursal(String id) async {
    final url = "$_url/sucursales/$id.json";
    final response = await http.delete(url);
    final decodedResp = json.decode(response.body);
    if (decodedResp == null)
      return true;
    else
      return false;
  }
}
