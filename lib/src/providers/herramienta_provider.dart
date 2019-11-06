

class HerramientaProvider {

  final _url = "https://zeos-app.firebaseio.com";

  Future<String> obtenerHerramientasSucursal(String idSucursal) async {
    final url = '$_url/herramientas.json';
    return url;
  }
  
}