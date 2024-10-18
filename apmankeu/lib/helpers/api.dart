import 'dart:convert'; // Untuk jsonEncode
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:apmankeu/helpers/user_infor.dart';
import 'app_exception.dart';

class Api {
  // POST request
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      print("URL: $url");
      print("Data: $data");
      print("Token: $token");

      // Set headers dengan pengecekan null pada token
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        if (token != null) HttpHeaders.authorizationHeader: "Bearer $token", // Tambahkan header Authorization jika token ada
      };

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data), // Kirim sebagai JSON
        headers: headers,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      responseJson = _returnResponse(response);  // Panggil handler untuk cek respons
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("Error during POST request: $e");
      throw FetchDataException('Error during POST request: $e');
    }

    return responseJson;
  }

  // GET request
  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print("URL: $url");
      print("Token: $token");

      // Set headers dengan pengecekan null pada token
      final headers = {
        if (token != null) HttpHeaders.authorizationHeader: "Bearer $token",
      };

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("Error during GET request: $e");
      throw FetchDataException('Error during GET request: $e');
    }
    return responseJson;
  }

  // PUT request
  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print("URL: $url");
      print("Data: $data");
      print("Token: $token");

      // Set headers dengan pengecekan null pada token
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        if (token != null) HttpHeaders.authorizationHeader: "Bearer $token",
      };

      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("Error during PUT request: $e");
      throw FetchDataException('Error during PUT request: $e');
    }
    return responseJson;
  }

  // DELETE request
  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      print("URL: $url");
      print("Token: $token");

      // Set headers dengan pengecekan null pada token
      final headers = {
        if (token != null) HttpHeaders.authorizationHeader: "Bearer $token",
      };

      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print("Error during DELETE request: $e");
      throw FetchDataException('Error during DELETE request: $e');
    }
    return responseJson;
  }

  // Helper method to handle HTTP responses
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        try {
          return jsonDecode(response.body);  // Coba decode body respons
        } catch (e) {
          throw FetchDataException('Failed to decode JSON: ${response.body}');
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server with status code: ${response.statusCode}',
        );
    }
  }
}