import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario.internal();

  //factory tipo de construccion unico
  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario.internal();
  SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //recordar nombres
  set recordarNombres(String nombres) {
    _prefs.setString('nombres', nombres);
  }

  get nombres {
    return _prefs.getString('nombres') ?? 'Diego';
  }

  //recordar apellidos
  set recordarApellidos(String apellidos) {
    _prefs.setString('apellidos', apellidos);
  }

  get apellidos {
    return _prefs.getString('apellidos') ?? 'Rosales';
  }

  //recordar telefono
  set recordarTelefono(String telefono) {
    _prefs.setString('telefono', telefono);
  }

  get telefono {
    return _prefs.getString('telefono') ?? '3223456745';
  }

  //recordar telefono
  set recordarEmail(String email) {
    _prefs.setString('email', email);
  }

  get email {
    return _prefs.getString('email') ?? 'info@gmail.com';
  }

//recordar tap
  set recordarTap(int tap) {
    _prefs.setInt('tap', tap);
  }

  get tap {
    return _prefs.getInt('tap') ?? 3;
  }

  //recordar avatar
  set recordarAvatar(String avatar) {
    _prefs.setString('avatar', avatar);
  }

  get avatar {
    return _prefs.getString('avatar') ??
        'https://www.latercera.com/resizer/Am6Tr2ws8JnL4CHLfU_Humpr56Q=/900x600/smart/arc-anglerfish-arc2-prod-copesa.s3.amazonaws.com/public/XMJRWZH5N5CBXPL67NAKBGXFNI.jpg';
  }

  borrarPreferencias() {
    _prefs.remove('avatar');
    _prefs.remove('email');
    _prefs.remove('nombres');
    _prefs.remove('apellidos');
    _prefs.remove('telefono');
  }
}
