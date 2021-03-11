import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.name,
    this.lastname,
    this.phone,
    this.email,
    this.password,
  });

  String name;
  String lastname;
  String phone;
  String email;
  String password;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "email": email,
        "password": password,
      };
}
