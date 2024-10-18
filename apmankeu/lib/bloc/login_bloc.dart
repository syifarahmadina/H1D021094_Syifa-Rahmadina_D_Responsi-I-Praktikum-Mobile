import 'package:apmankeu/helpers/api.dart';
import 'package:apmankeu/helpers/api_url.dart';
import 'package:apmankeu/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    try {
      var response = await Api().post(apiUrl, body);

      if (response['code'] == 200 && response['status'] == true) {
        return Login.fromJson(response);
      } else {
        throw Exception('Login gagal: ${response['data']}');
      }
    } catch (error) {
      print("Login Error: $error");
      rethrow;
    }
  }
}