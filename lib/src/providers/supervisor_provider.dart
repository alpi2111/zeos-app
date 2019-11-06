import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:constructor_rajuma/src/models/supervisor_model.dart';

class SupervisorProvider {
  final String _url = "https://zeos-app.firebaseio.com";
  final _firebaseToken = 'AIzaSyDnmxHyzBkl8ODKAEsFn9XhoGDev3_cars';

  Future<Map<String, dynamic>> agregarSupervisor(SupervisorModel model) async {
    final url = "$_url/supervisores/${model.idSupervisor}.json";

    final response =
        await http.put(url, body: supervisorModelToJsonNoFull(model));

    final decodedData = json.decode(response.body);
    /*print(url);
    print(response.body);
    print(model.toJsonNoFull());
    print(decodedData);*/
    if (decodedData != null) {
      //if(decodedData.)
      return {'ok': true};
    } else {
      return {'ok': false};
    }
  }

  Future<List<SupervisorModel>> obtenerEncargados() async {
    final url = "$_url/supervisores.json";

    final response = await http.get(url);

    final Map<String, dynamic> decodedResp = json.decode(response.body);
    final List<SupervisorModel> supervisores = List();

    if (decodedResp == null) return [];

    decodedResp.forEach((id, val) {
      final supTemp = SupervisorModel.fromJson(val);
      supTemp.idSupervisor = id;
      supervisores.add(supTemp);
    });
    return supervisores;
  }

  Future<Map<String, dynamic>> nuevoLoginSupervisor(
      SupervisorModel model) async {
    final authData = {
      'email': '${model.idSupervisor}@rajuma.com',
      'password': model.password,
      'returnSecureToken': true
    };

    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";

    final response = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedData = json.decode(response.body);

    //print(decodedData['idToken']);

    if (decodedData.containsKey('idToken'))
      return {'ok': true, 'token': decodedData['idToken']};
    else
      return {'ok': false, 'token': ''};
  }

  Future<bool> eliminarSupervisor(String id, String token) async {
    //print("token: $token");
    final url = '$_url/supervisores/$id.json';
    final url2 =
        'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$_firebaseToken';

    final response = await http.delete(url);

    final authData = {
      "idToken": "$token"
    };
    final response2 = await http.post(url2, body: json.encode(authData));

    final decodedResp = json.decode(response.body);
    final decodedResp2 = json.decode(response2.body);
    //print(decodedResp2);
    if (decodedResp == null && decodedResp2 != null)
      return true;
    else
      return false;
  }
}
