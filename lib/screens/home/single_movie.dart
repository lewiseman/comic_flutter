import 'package:comics/root.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleMoviePage extends StatelessWidget {
  const SingleMoviePage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              backgroundColor: bgColor,
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(movie.title),
                background: Container(
                  child: Stack(
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        width: size.width,
                        fit: BoxFit.cover,
                        image:
                            'https://www.themoviedb.org/t/p/w220_and_h330_face/${movie.backdropPath}',
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
        body: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  movie.overview,
                  style:
                      GoogleFonts.poppins(letterSpacing: 1.6, wordSpacing: 1.5),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  movie.releaseDate,
                  style:
                      GoogleFonts.poppins(letterSpacing: 1.6, wordSpacing: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
