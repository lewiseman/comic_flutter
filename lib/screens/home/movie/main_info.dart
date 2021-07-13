import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({
    Key? key,
    required this.initMovie,
    required this.movie,
  }) : super(key: key);

  final Movie initMovie;
  final SingleMovie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(
                    'https://www.themoviedb.org/t/p/w220_and_h330_face/${initMovie.backdropPath}',
                  ),
                  fit: BoxFit.cover),
            ),
            height: 200,
            width: 140,
          ),
          Container(
            margin: EdgeInsets.only(left: 6.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Title: ',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${initMovie.title}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Running Time: ',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${movie.runtime} min',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Release Date: ',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${initMovie.releaseDate}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'data: ',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'data',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'data: ',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'data',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
