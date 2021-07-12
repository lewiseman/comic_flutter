import 'package:flutter/material.dart';

import 'screens/home/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comics',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}
