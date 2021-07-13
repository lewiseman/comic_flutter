import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:comics/widgets/percent/tmdb_progress.dart';
import 'package:comics/widgets/toggle/toggle_tittle.dart';
import 'package:comics/widgets/toggle/toggler.dart';
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
              Toggler(
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
                child: RecentData(
                  address: 'movie/upcoming',
                ),
              ),
              secondChild: Container(
                height: size.height * .28,
                width: size.width,
                child: RecentData(
                  address: 'movie/now_playing',
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

class RecentData extends StatefulWidget {
  const RecentData({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  _RecentDataState createState() => _RecentDataState();
}

class _RecentDataState extends State<RecentData> {
  @override
  Widget build(BuildContext context) {
    Future<List<Movie>> data = getMovie(widget.address);
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
                itemBuilder: (context, index) => SingleCard(
                  movie: movie[index],
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
  final Movie movie;
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
                      'https://www.themoviedb.org/t/p/w220_and_h330_face/${movie.backdropPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                width: size.width * .30,
                height: size.height * .20,
              ),
              Positioned(
                bottom: -18,
                left: 30,
                child: MovieRateIndicator(
                  percent: 20,
                ),
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
