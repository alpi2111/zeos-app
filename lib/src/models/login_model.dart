import 'dart:convert';

LoginModel usuarioModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String usuarioModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String usuario = '';
  String password = '';

  LoginModel({
    this.usuario = '',
    this.password = '',
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        usuario: json["usuario"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "password": password,
      };
}
