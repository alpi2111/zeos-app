// To parse this JSON data, do
//
//     final empleadoModel = empleadoModelFromJson(jsonString);

import 'dart:convert';

EmpleadoModel empleadoModelFromJson(String str) => EmpleadoModel.fromJson(json.decode(str));

String empleadoModelToJsonFull(EmpleadoModel data) => json.encode(data.toJsonFull());
String empleadoModelToJsonNoFull(EmpleadoModel data) => json.encode(data.toJsonNoFull());

class EmpleadoModel {
    String idEmpleado;
    String idSucursal;
    String nombre;
    String pass;

    EmpleadoModel({
        this.idEmpleado,
        this.idSucursal,
        this.nombre,
        this.pass
    });

    factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
        idEmpleado: json["id_empleado"],
        idSucursal: json["id_sucursal"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJsonFull() => {
        "id_empleado": idEmpleado,
        "id_sucursal": idSucursal,
        "nombre": nombre,
        "pass": pass,
    };
    
    Map<String, dynamic> toJsonNoFull() => {
        //"id_empleado": idEmpleado,
        "id_sucursal": idSucursal,
        "nombre": nombre,
        "pass": pass,
    };
}
