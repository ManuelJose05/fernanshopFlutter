import 'package:http/http.dart';
import 'package:practica_obligatoria_tema5_fernanshop/env.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';

class UsersService {
  Future<Users?> loginWithEmailAndPass(String email, String pass)async{
    Uri uri = Uri.parse('${Env.endPointBase}/auth/login');
    Response response = await post(uri, headers: {'api_key': Env.apiKey}, body: {'email':email,'pass':pass});
    if (response.statusCode != 200) return null;
    Users usuarioResponse = userFromJson(response.body);
    return usuarioResponse;
  }
}