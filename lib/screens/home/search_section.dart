import 'package:flutter/material.dart';

class SearchPart extends StatelessWidget {
  const SearchPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: TextStyle(fontSize: 10),
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 8),
              child: Text(
                'Movie, Actors, Directors ...',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w200),
              ),
            ),
            onTap: () async {
            },
          ),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}