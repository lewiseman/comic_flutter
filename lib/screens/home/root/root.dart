import 'package:comics/root.dart';
import 'package:comics/screens/drawer/root.dart';
import 'package:comics/widgets/swiper/swipe_drawer.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'popular_section.dart';
import 'trending_section.dart';
import 'search_section.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SwipeDrawer(
          radius: 25,
          bodyBackgroundPeekSize: 30,
          drawer: buildDrawer(),
          key: drawerKey,
          child: buildBody(size),
        ),
      ),
    );
  }

  NestedScrollView buildBody(Size size) {
    return NestedScrollView(
      headerSliverBuilder: (context, index) {
        return [
          SliverAppBar(
            backgroundColor: bgColor,
            elevation: 0,
            expandedHeight: 230.0,
            pinned: true,
            leading: InkWell(
              onTap: () {
                if (drawerKey.currentState!.isOpened()) {
                  drawerKey.currentState!.closeDrawer();
                } else {
                  drawerKey.currentState!.openDrawer();
                }
              },
              child: Icon(Icons.menu),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: SearchPart(),
              background: Container(
                child: Stack(
                  children: [
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      width: size.width,
                      fit: BoxFit.cover,
                      image:
                          'https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            bgColor.withOpacity(0),
                            bgColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: Container(
        color: bgColor,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              PopularPart(),
              TrendingPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return AppDrawer();
  }
}
