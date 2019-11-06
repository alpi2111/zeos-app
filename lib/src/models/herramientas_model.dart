import 'dart:convert';

HerramientasModel herramientasModelFromJson(String str) => HerramientasModel.fromJson(json.decode(str));

String herramientasModelToJsonFull(HerramientasModel data) => json.encode(data.toJsonFull());
String herramientasModelToJsonNoFull(HerramientasModel data) => json.encode(data.toJsonNoFull());

class HerramientasModel {
    String idHerramienta; //el nodo que contendra los demás hijos
    String feEnt;
    String feSal;
    String idEmpleado;
    String idSucursal;
    String tipo;
    String nombreHerramienta;

    HerramientasModel({
        this.idHerramienta,
        this.feEnt,
        this.feSal,
        this.idEmpleado,
        this.idSucursal,
        this.tipo,
        this.nombreHerramienta,
    });

    factory HerramientasModel.fromJson(Map<String, dynamic> json) => HerramientasModel(
        idHerramienta: json["id_herramienta"],
        feEnt: json["fe_ent"],
        feSal: json["fe_sal"],
        idEmpleado: json["id_empleado"],
        idSucursal: json["id_sucursal"],
        tipo: json["tipo"],
        nombreHerramienta: json["nombre_herramienta"],
    );

    Map<String, dynamic> toJsonFull() => {
      //envia el id de la herramienta a la base de datos local
        "id_herramienta": idHerramienta,
        "fe_ent": feEnt,
        "fe_sal": feSal,
        "id_empleado": idEmpleado,
        "id_sucursal": idSucursal,
        "tipo": tipo,
        "nombre_herramienta": nombreHerramienta,
    };

    Map<String, dynamic> toJsonNoFull() => {
      //NO envia el id de la herramienta a la base de datos local
        //"id_herramienta": idHerramienta,
        "fe_ent": feEnt,
        "fe_sal": feSal,
        "id_empleado": idEmpleado,
        "id_sucursal": idSucursal,
        "tipo": tipo,
        "nombre_herramienta": nombreHerramienta,
    };
}
