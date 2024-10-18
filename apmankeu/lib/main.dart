import 'package:flutter/material.dart';
import 'package:apmankeu/helpers/user_infor.dart';
import 'package:apmankeu/ui/login_page.dart';
import 'package:apmankeu/ui/mata_uang_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }
  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const MataUangPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}