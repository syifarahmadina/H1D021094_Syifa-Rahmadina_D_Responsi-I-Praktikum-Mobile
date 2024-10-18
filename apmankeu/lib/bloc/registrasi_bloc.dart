import 'dart:convert';
import 'package:apmankeu/helpers/api.dart';
import 'package:apmankeu/helpers/api_url.dart';
import 'package:apmankeu/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"nama": nama, "email": email, "password": password};

    try {
      // Panggil API dan langsung terima hasil JSON (tidak perlu decode lagi)
      var response = await Api().post(apiUrl, body);

      // Tidak perlu decode lagi, asumsikan response sudah dalam bentuk map
      if (response['code'] == 200 && response['status'] == true) {
        return Registrasi.fromJson(response); // Menggunakan response langsung
      } else {
        // Jika status code bukan 200 atau status false, lempar error
        throw Exception('Registrasi gagal: ${response['data']}');
      }
    } catch (error) {
      // Log error untuk debugging
      print("Registrasi Error: $error");
      rethrow;
    }
  }
}