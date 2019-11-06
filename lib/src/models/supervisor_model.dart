import 'dart:convert';

SupervisorModel supervisorModelFromJson(String str) => SupervisorModel.fromJson(json.decode(str));

String supervisorModelToJsonFull(SupervisorModel data) => json.encode(data.toJsonFull());
String supervisorModelToJsonNoFull(SupervisorModel data) => json.encode(data.toJsonNoFull());

class SupervisorModel {
    String idSupervisor;
    String idToken;
    String password;
    String nombre;

    SupervisorModel({
        this.idSupervisor,
        this.idToken,
        this.password,
        this.nombre,
    });

    factory SupervisorModel.fromJson(Map<String, dynamic> json) => SupervisorModel(
        idSupervisor: json["id_supervisor"],
        idToken: json["idToken"],
        password: json["password"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJsonFull() => {
        "id_supervisor": idSupervisor,
        "idToken": idToken,
        "password": password,
        "nombre": nombre,
    };
    Map<String, dynamic> toJsonNoFull() => {
        //"id_supervisor": idSupervisor,
        "idToken": idToken,
        "password": password,
        "nombre": nombre,
    };
}
