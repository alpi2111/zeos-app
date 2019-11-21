// To parse this JSON data, do
//
//     final herramientaModel = herramientaModelFromJson(jsonString);

import 'dart:convert';

HerramientaModel herramientaModelFromJson(String str) => HerramientaModel.fromJson(json.decode(str));

String herramientaModelToJson(HerramientaModel data) => json.encode(data.toJson());

class HerramientaModel {
    String nombre;
    bool disponible;
    String idHerramienta;
    String idSucursal;
    String idFb;

    HerramientaModel({
        this.nombre,
        this.disponible,
        this.idHerramienta,
        this.idSucursal,
        this.idFb,
    });

    factory HerramientaModel.fromJson(Map<String, dynamic> json) => HerramientaModel(
        nombre: json["nombre"],
        disponible: json["disponible"],
        idHerramienta: json["id_herramienta"],
        idSucursal: json["id_sucursal"],
        idFb: json["id_fb"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "disponible": disponible,
        "id_herramienta": idHerramienta,
        "id_sucursal": idSucursal,
        "id_fb": idFb,
    };
}
