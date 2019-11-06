// To parse this JSON data, do
//
//     final sucursalModel = sucursalModelFromJson(jsonString);

import 'dart:convert';

SucursalModel sucursalModelFromJson(String str) => SucursalModel.fromJson(json.decode(str));

String sucursalModelToJsonFull(SucursalModel data) => json.encode(data.toJsonFull());
String sucursalModelToJsonNoFull(SucursalModel data) => json.encode(data.toJsonNoFull());

class SucursalModel {
    String idSucursal;
    String idSupervisor;
    String direccion;
    String nombre;

    SucursalModel({
        this.idSucursal,
        this.idSupervisor,
        this.nombre,
        this.direccion,
    });

    factory SucursalModel.fromJson(Map<String, dynamic> json) => SucursalModel(
        idSucursal: json["id_sucursal"],
        idSupervisor: json["id_supervisor"],
        nombre: json["nombre"],
        direccion: json["direccion"],
    );

    Map<String, dynamic> toJsonFull() => {
        "id_sucursal": idSucursal,
        "id_supervisor": idSupervisor,
        "nombre": nombre,
        "direccion": direccion,
    };
    Map<String, dynamic> toJsonNoFull() => {
        //"id_sucursal": idSucursal,
        "id_supervisor": idSupervisor,
        "nombre": nombre,
        "direccion": direccion,
    };
}
