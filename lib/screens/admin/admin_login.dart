import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/CommonUtils.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonUtils.myAppBar("Admin","Login"),
    );
  }
}
