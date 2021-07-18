import 'package:comics/root.dart';
import 'package:comics/screens/movies/root.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieTypes(),
                          ),
                        );
                      }),
                  ListTile(
                    title: Text(
                      'Now Playing',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Upcoming',
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
          FlutterLogo(size: 100),
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
