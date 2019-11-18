// To parse this JSON data, do
//
//     final entradaSalidaModel = entradaSalidaModelFromJson(jsonString);

import 'dart:convert';

EntradaSalidaModel entradaSalidaModelFromJson(String str) => EntradaSalidaModel.fromJson(json.decode(str));

String entradaSalidaModelToJson(EntradaSalidaModel data) => json.encode(data.toJson());

class EntradaSalidaModel {
    String idEmpleado;
    String idHerramienta;
    String idSucursal;
    String hEntrada;
    String hSalida;

    EntradaSalidaModel({
        this.idEmpleado,
        this.idHerramienta,
        this.idSucursal,
        this.hEntrada,
        this.hSalida,
    });

    factory EntradaSalidaModel.fromJson(Map<String, dynamic> json) => EntradaSalidaModel(
        idEmpleado: json["id_empleado"],
        idHerramienta: json["id_herramienta"],
        idSucursal: json["id_sucursal"],
        hEntrada: json["h_entrada"],
        hSalida: json["h_salida"],
    );

    Map<String, dynamic> toJson() => {
        "id_empleado": idEmpleado,
        "id_herramienta": idHerramienta,
        "id_sucursal": idSucursal,
        "h_entrada": hEntrada,
        "h_salida": hSalida,
    };
}
