import 'package:comics/screens/search/root.dart';
import 'package:flutter/material.dart';

class SearchPart extends StatelessWidget {
  const SearchPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Text(
                    's',
                    // 'Movie, Actors, Directors ...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: 1,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(Icons.search),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
