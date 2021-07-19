import 'package:comics/root.dart';
import 'package:comics/screens/movies/now_playing.dart';
import 'package:comics/screens/movies/root.dart';
import 'package:comics/screens/movies/top_rated.dart';
import 'package:comics/screens/movies/upcoming.dart';
import 'package:comics/widgets/swiper/swipe_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key, required this.drawerKey}) : super(key: key);
  final GlobalKey<SwipeDrawerState> drawerKey;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<bool> isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final List<Widget> expansionHead = [
    ListTile(
      title: Text(
        'Movies',
        style: GoogleFonts.poppins(fontSize: 16),
      ),
    ),
    ListTile(
      title: Text(
        'TV Shows',
        style: GoogleFonts.poppins(fontSize: 16),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Widget> expansionHead = [
      ListTile(
        title: Text(
          'Movies',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        onTap: () {
          setState(() {
            isOpen[0] = !isOpen[0];
          });
        },
      ),
      ListTile(
        title: Text(
          'TV Shows',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
    ];
    final List<Widget> expansionBody = [
      Container(
        margin: EdgeInsets.only(left: 32),
        // fix hegight issue with the post call back method
        height: 224,
        child: Row(
          children: [
            Container(
              width: 5,
              color: Colors.green,
            ),
            Container(
              width: 120,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Popular',
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      setState(() {
                        isOpen[0] = !isOpen[0];
                      });
                      widget.drawerKey.currentState!.closeDrawer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieTypes(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Now Playing',
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      setState(() {
                        isOpen[0] = !isOpen[0];
                      });
                      widget.drawerKey.currentState!.closeDrawer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Upcoming',
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      setState(() {
                        isOpen[0] = !isOpen[0];
                      });
                      widget.drawerKey.currentState!.closeDrawer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Upcoming(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Top Rated',
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      setState(() {
                        isOpen[0] = !isOpen[0];
                      });
                      widget.drawerKey.currentState!.closeDrawer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopRated(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 32),
        height: 224,
        child: Row(
          children: [
            Container(
              width: 5,
              color: Colors.green,
            ),
            Container(
              width: 120,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Popular',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Airing Today',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'On TV',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Top Rated',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
    return Container(
      margin: EdgeInsets.only(right: 40),
      child: Column(
        children: [
          SizedBox(height: size.height * .10),
          FlutterLogo(size: 50),
          SizedBox(height: size.height * .05),
          ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isOpen[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: bgColor.withOpacity(0),
                headerBuilder: (context, isOpen) => expansionHead[0],
                body: expansionBody[0],
                isExpanded: isOpen[0],
              ),
              ExpansionPanel(
                backgroundColor: bgColor.withOpacity(0),
                headerBuilder: (context, isOpen) => expansionHead[1],
                body: expansionBody[1],
                isExpanded: isOpen[1],
              ),
            ],
          ),
          ListTile(
            title: Text('People'),
          )
        ],
      ),
    );
  }
}

class ExpansionThings {
  ExpansionThings(
      {required this.body, required this.head, required this.opened});

  final Widget body;
  final Widget head;
  final bool opened;
}
