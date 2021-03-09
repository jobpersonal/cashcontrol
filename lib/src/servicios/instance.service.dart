import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Intance {
  final _baseUrl = "https://1c58d04ba2b9.ngrok.io/";
  Future post(String url, {Map<String, dynamic> data}) async {
    try {
      final request = await http.post(
        "$_baseUrl$url",
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (request.statusCode == 500) {
        return Future.error("Internal Server Error");
      } else if (request.statusCode == 401) {
        return Future.error("No authentacated");
      }

      return json.decode(request.body);
    } on SocketException {
      return Future.error('No Internet connection 😑');
    } on FormatException {
      return Future.error('Bad response format 👎');
    } on Exception {
      return Future.error('Unexpected error 😢');
    }
  }

  Future geT(String url, {Map<String, dynamic> data}) async {
    try {
      final request = await http.get(
        "$_baseUrl$url",
        headers: {'Content-Type': 'application/json'},        
      );

      if (request.statusCode == 500) {
        return Future.error("Internal Server Error");
      } else if (request.statusCode == 401) {
        return Future.error("No authentacated");
      }

      return json.decode(request.body);
    } on SocketException {
      return Future.error('No Internet connection 😑');
    } on FormatException {
      return Future.error('Bad response format 👎');
    } on Exception {
      return Future.error('Unexpected error 😢');
    }
  }
}
