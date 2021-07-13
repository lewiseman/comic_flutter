import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class Stats extends StatelessWidget {
  const Stats({
    Key? key,
    required this.statis,
  }) : super(key: key);

  final SingleMovie statis;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '${statis.voteAverage}',
                style: GoogleFonts.paprika(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              Text('Vote Average'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.comment),
              Text('${statis.voteCount} votes'),
            ],
          ),
          Column(
            children: [
              LikeButton(),
              Text('Rate this'),
            ],
          ),
        ],
      ),
    );
  }
}
