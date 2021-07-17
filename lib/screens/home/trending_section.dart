import 'package:animations/animations.dart';
import 'package:comics/root.dart';
import 'package:comics/screens/home/movie/single_movie.dart';
import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:comics/sevices/tmdb/tv.dart';
import 'package:comics/widgets/percent/tmdb_progress.dart';
import 'package:comics/widgets/toggle/toggle_tittle.dart';
import 'package:comics/widgets/toggle/toggler_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingPart extends StatefulWidget {
  const TrendingPart({Key? key}) : super(key: key);

  @override
  _TrendingPartState createState() => _TrendingPartState();
}

class _TrendingPartState extends State<TrendingPart> {
  ValueNotifier<bool> isOnTv = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              toggleTittle('Trending'),
              Spacer(),
              TogglerGradient(
                isFirst: isOnTv,
                firstTitle: 'Today',
                secondTitle: 'This Week',
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          builder: (BuildContext context, bool value, Widget? child) {
            return AnimatedCrossFade(
              firstChild: Container(
                height: size.height * .28,
                width: size.width,
                child: OnTv(
                  address: 'tv/latest',
                ),
              ),
              secondChild: Container(
                height: size.height * .28,
                width: size.width,
                child: InTheaters(
                  address: 'movie/upcoming',
                ),
              ),
              crossFadeState:
                  value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(seconds: 1),
            );
          },
          valueListenable: isOnTv,
        ),
      ],
    );
  }
}

class OnTv extends StatefulWidget {
  const OnTv({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  _OnTvState createState() => _OnTvState();
}

class _OnTvState extends State<OnTv> {
  Future<List<Tv>> data = getTv('tv/popular');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<List<Tv>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('data');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CupertinoActivityIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            if (snapshot.hasData) {
              List<Tv>? movie = snapshot.data;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movie!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => OpenContainer(
                  middleColor: bgColor,
                  closedColor: bgColor,
                  openColor: bgColor,
                  closedBuilder: (context, close) => SingleCard(
                    movie: movie[index],
                  ),
                  openBuilder: (context, open) => Text('data'),
                ),
              );
            }
            return Text('unknown');
          default:
            return Text('data');
        }
      },
    );
  }
}

class InTheaters extends StatefulWidget {
  const InTheaters({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  _InTheatersState createState() => _InTheatersState();
}

class _InTheatersState extends State<InTheaters> {
  @override
  Widget build(BuildContext context) {
    Future<List<Movie>> data = getMovies(widget.address);
    return FutureBuilder(
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
              List<Movie>? movie = snapshot.data;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movie!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => OpenContainer(
                  middleColor: bgColor,
                  closedColor: bgColor,
                  openColor: bgColor,
                  closedBuilder: (context, close) => SingleCard(
                    movie: movie[index],
                  ),
                  openBuilder: (context, open) => SingleMoviePage(
                    movie: movie[index],
                  ),
                ),
              );
            }
            return Text('unknown');
          default:
            return Text('data');
        }
      },
    );
  }
}

class SingleCard extends StatelessWidget {
  final dynamic movie;
  const SingleCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
