import 'dart:async';
import 'package:cashcontrol/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _telefonoController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream

  Stream<String> get telefonoStream =>
      _telefonoController.stream.transform(validarTelefono);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(telefonoStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get telefono => _telefonoController.value;
  String get password => _passwordController.value;

  dispose() {
    _telefonoController?.close();
    _passwordController?.close();
  }
}
