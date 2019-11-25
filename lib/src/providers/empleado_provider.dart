import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/models/empleado_model.dart';

class EmpleadoProvider {
  final _url = "https://zeos-app.firebaseio.com";

  Future<List<EmpleadoModel>> obtenerTodosEmpleados() async {
    final url = "$_url/empleados.json";

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    //if(decodedResp.)
    //print(decodedResp);

    List<EmpleadoModel> lista = List<EmpleadoModel>();

    decodedResp.forEach((key, val) {
      final temp = EmpleadoModel();
      temp.idSucursal = val['id_sucursal'];
      temp.idEmpleado = key;
      temp.nombre = val['nombre'];
      lista.add(temp);
      //print(lista[0].nombre);
    });

    return lista;
    //print(decodedResp);
  }

  Future<List<EmpleadoModel>> obtenerEmpleadoSucursal(String id) async {
    final url = '$_url/empleados.json?orderBy="id_sucursal"&equalTo="$id"';

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    final List<EmpleadoModel> lista = List<EmpleadoModel>();

    //print(decodedResp.containsKey('id_sucursal'));
    //print(decodedResp);

    if (decodedResp != null) {
      //return []; //aqui debe ir lo de los datos
      decodedResp.forEach((key, val) {
        /*print(key);
        print(val);*/
        final temp = EmpleadoModel();
        temp.idEmpleado = key;
        temp.idSucursal = val['id_sucursal'];
        temp.nombre = val['nombre'];
        lista.add(temp);
      });
      return lista;
    } else {
      return [];
    }
  }

  Future<bool> agregarEmpleado(EmpleadoModel model) async {
    final url = "$_url/empleados/${model.idEmpleado}.json";

    final response =
        await http.put(url, body: empleadoModelToJsonNoFull(model));

    final decodedResp = json.decode(response.body);

    //print(decodedResp);
    if (decodedResp != null)
      return true;
    else
      return false;
  }

  Future<bool> eliminarEmpleado(String id) async {
    final url = "$_url/empleados/$id.json";

    final response = await  http.delete(url);

    final decodedRes = json.decode(response.body);

    print(decodedRes);
    return true;
  }
}
