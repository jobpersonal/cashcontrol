import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.nombres,
    this.apellidos,
    this.telefono,
    this.email,
    this.avatar,
    this.password,
  });

  String nombres;
  String apellidos;
  String telefono;
  String email;
  String avatar;
  String password;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        email: json["email"],
        avatar: json["avatar"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "email": email,
        "avatar": avatar,
        "password": password,
      };
}
