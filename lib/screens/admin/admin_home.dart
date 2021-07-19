import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/CommonUtils.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonUtils.myAppBar("Admin","Home"),
    );
  }
}
