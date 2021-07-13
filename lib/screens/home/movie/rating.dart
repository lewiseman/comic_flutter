import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key, required this.voteCount,
  }) : super(key: key);
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.pink,
          ),
          Icon(
            Icons.star,
            color: Colors.pink,
          ),
          Icon(
            Icons.star,
            color: Colors.pink,
          ),
          Icon(
            Icons.star,
            color: Colors.pink,
          ),
          Icon(
            Icons.star_border,
            color: Colors.pink,
          ),
          Text('$voteCount  Reviews')
        ],
      ),
    );
  }
}
