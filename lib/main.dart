import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/user/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterBlog',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
