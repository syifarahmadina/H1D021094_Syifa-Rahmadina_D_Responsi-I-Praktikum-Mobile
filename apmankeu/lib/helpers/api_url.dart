class ApiUrl {
  static const String baseUrl = 'http://192.168.71.2:8080';
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listMataUang = '$baseUrl/mata-uang';
  static const String createMataUang = '$baseUrl/mata-uang';

  static String updateMataUang(int id) {
    return '$baseUrl/mata-uang/$id';
  }

  static String showMataUang(int id) {
    return '$baseUrl/mata-uang/$id';
  }

  static String deleteMataUang(int id) {
    return '$baseUrl/mata-uang/$id';
  }
}