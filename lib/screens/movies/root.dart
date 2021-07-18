import 'package:animations/animations.dart';
import 'package:comics/root.dart';
import 'package:comics/screens/home/movie/single_movie.dart';
import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:comics/widgets/percent/tmdb_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieTypes extends StatelessWidget {
  const MovieTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Popular'),
      ),
      body: PopularMovies(),
    );
  }
}

class PopularMovies extends StatefulWidget {
  PopularMovies({Key? key}) : super(key: key);

  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  Future<List<Movie>> data = getMovies('movie/now_playing');
  List<Movie>? movie = [];
  ScrollController _scrollController = ScrollController();
  int nextPage = 2;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreData();
        }
      },
    );
  }

  void _getMoreData() {
    Future<List<Movie>> fetchedData =
        getMoviesPaginated('movie/now_playing', nextPage);
    fetchedData.then(
      (value) => value.forEach(
        (element) {
          movie!.add(element);
        },
      ),
    );
    nextPage += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('data');
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              if (snapshot.hasData) {
                movie = snapshot.data;
                return GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: movie!.length,
                  itemBuilder: (context, index) => OpenContainer(
                    middleColor: bgColor,
                    closedColor: bgColor,
                    openColor: bgColor,
                    closedBuilder: (context, close) => SingleMovieGrid(
                      movie: movie![index],
                      size: size,
                    ),
                    openBuilder: (context, open) => SingleMoviePage(
                      movie: movie![index],
                    ),
                  ),
                );
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            default:
              return Text('data');
          }
        },
      ),
      // GridView.builder(
      //   physics: BouncingScrollPhysics(),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //     childAspectRatio: 0.5,
      //   ),
      //   itemBuilder: (index, context) {
      //     return SingleMovieGrid(size: size);
      //   },
      // ),
    );
  }
}

class SingleMovieGrid extends StatelessWidget {
  const SingleMovieGrid({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .35,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://www.themoviedb.org/t/p/w220_and_h330_face/${movie.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                width: size.width * .30,
                height: size.height * .20,
              ),
              Positioned(
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Save Item"),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text("Watch later"),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text("Add Review"),
                      value: 2,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -18,
                left: 30,
                child: MovieRateIndicator(percent: movie.voteAverage * 10),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 18),
            child: Text(
              '${movie.title}',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
