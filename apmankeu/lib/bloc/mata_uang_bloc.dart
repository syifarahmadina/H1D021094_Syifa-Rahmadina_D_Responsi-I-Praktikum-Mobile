import 'dart:convert';
import 'package:apmankeu/helpers/api.dart';
import 'package:apmankeu/helpers/api_url.dart';
import 'package:apmankeu/model/mata_uang.dart';

class MataUangBloc {
  // Fungsi untuk mengambil list mata uang dari API
  static Future<List<MataUang>> getMataUang() async {
    try {
      String apiUrl = ApiUrl.listMataUang;
      var response = await Api().get(apiUrl);

      print('Response: $response');

      if (response != null && response['status'] == true) {
        List<dynamic> listMataUang = response['data'];

        List<MataUang> mataUangs = listMataUang.map((data) => MataUang.fromJson(data)).toList();

        print('List mata uang: $mataUangs');
        return mataUangs;
      } else {
        throw Exception('Failed to load mata uang or status is false');
      }
    } catch (e) {
      print('Error fetching mata uang: $e');
      return [];
    }
  }

  // Fungsi untuk menambahkan mata uang baru ke API
  static Future<bool> addMataUang({required MataUang mataUang}) async {
    try {
      String apiUrl = ApiUrl.createMataUang;
      var body = jsonEncode({
        "currency": mataUang.currency,
        "exchange_rate": mataUang.exchangeRate,
        "symbol": mataUang.symbol,
      });

      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);

      print('Add mata uang response: $jsonObj');

      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to save mata uang');
      }
    } catch (e) {
      print('Error adding mata uang: $e');
      return false;
    }
  }

  // Fungsi untuk memperbarui mata uang yang ada di API
  static Future<bool> updateMataUang({required MataUang mataUang}) async {
    try {
      String apiUrl = ApiUrl.updateMataUang(int.parse(mataUang.id!));
      var body = jsonEncode({
        "currency": mataUang.currency,
        "exchange_rate": mataUang.exchangeRate,
        "symbol": mataUang.symbol,
      });

      var response = await Api().put(apiUrl, body);
      var jsonObj = json.decode(response.body);

      print('Update mata uang response: $jsonObj');

      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to update mata uang');
      }
    } catch (e) {
      print('Error updating mata uang: $e');
      return false;
    }
  }

  // Fungsi untuk menghapus mata uang dari API
  static Future<bool> deleteMataUang({required int id}) async {
    try {
      String apiUrl = ApiUrl.deleteMataUang(id);
      var response = await Api().delete(apiUrl);
      var jsonObj = json.decode(response.body);

      print('Delete mata uang response: $jsonObj');

      if (jsonObj.containsKey('status') && jsonObj['status'] == true) {
        return true;
      } else {
        throw Exception('Failed to delete mata uang');
      }
    } catch (e) {
      print('Error deleting mata uang: $e');
      return false;
    }
  }
}
