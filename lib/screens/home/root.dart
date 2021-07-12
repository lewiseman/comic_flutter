import 'package:comics/root.dart';
import 'package:flutter/material.dart';

import 'popular_section.dart';
import 'recent_section.dart';
import 'search_section.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        toolbarHeight: kToolbarHeight * .6,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [SearchPart(), RecentPart(), PopularPart()],
          ),
        ),
      ),
    );
  }
}
