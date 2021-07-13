import 'package:comics/root.dart';
import 'package:comics/screens/home/movie/genre.dart';
import 'package:comics/screens/home/movie/rating.dart';
import 'package:comics/screens/home/movie/stats.dart';
import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:like_button/like_button.dart';

import 'main_info.dart';

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
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LikeButton(),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(movie.title),
                background: Container(
                  child: Stack(
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        width: size.width,
                        height: 300,
                        fit: BoxFit.cover,
                        image:
                            'https://www.themoviedb.org/t/p/w1920_and_h800_multi_faces${movie.backdropPath}',
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SingleMovieBody(initMovie: movie),
        ),
      ),
    );
  }
}

class SingleMovieBody extends StatelessWidget {
  const SingleMovieBody({
    Key? key,
    required this.initMovie,
  }) : super(key: key);

  final Movie initMovie;

  @override
  Widget build(BuildContext context) {
    Future<SingleMovie> singleData = getSingleMovie(initMovie.id);
    return FutureBuilder(
      future: singleData,
      builder: (BuildContext context, AsyncSnapshot<SingleMovie> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('data');
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.done:
            if (snapshot.hasData) {
              SingleMovie? movie = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      '\"${movie!.tagline}\"',
                      style: GoogleFonts.paprika(),
                      maxLines: 1,
                    ),
                  ),
                  Rating(
                    voteCount: movie.voteCount,
                  ),
                  Genre(
                    genres: movie.genre,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(),
                  ),
                  Stats(
                    statis: movie,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(),
                  ),
                  MainInfo(
                    initMovie: initMovie,
                    movie: movie,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      'Overview',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        initMovie.overview,
                        style: GoogleFonts.poppins(
                            letterSpacing: 1.6, wordSpacing: 1.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Divider(),
                  ),
                ],
              );
            } else {
              return Text(snapshot.error.toString());
            }

          //return Text(snapshot.data!.title);
          default:
            return Text('data');
        }
      },
    );
  }
}
