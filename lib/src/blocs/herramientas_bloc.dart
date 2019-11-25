

import 'dart:async';

//import 'package:constructor_rajuma/src/models/herramienta_model.dart';
//import 'package:constructor_rajuma/src/providers/entrada_salida_provider.dart';

class HerramientasBloc {

  static final HerramientasBloc _instancia = HerramientasBloc._internal();

  factory HerramientasBloc() {
    return _instancia;
  }

  HerramientasBloc._internal();

  final _streamController = StreamController<List<String>>.broadcast();

  Stream<List<String>> get herramientaStrem => _streamController.stream;

  dispose() {
    _streamController?.close();
  }

  agregarSalida() async {
    //_streamController.sink.add(await EntradaSalidaProvider().obtenerEnAlmacen());
    //EntradaSalidaProvider().updateHerramientaDisponible(id, dispo)
  }
}