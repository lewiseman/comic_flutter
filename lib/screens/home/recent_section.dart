import 'package:comics/sevices/marvel/series.dart';
import 'package:flutter/material.dart';

class RecentPart extends StatelessWidget {
  const RecentPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Text(
                'Recent',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                'SEE ALL',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * .25,
          child: RecentData(),
        )
      ],
    );
  }
}

class RecentData extends StatefulWidget {
  const RecentData({
    Key? key,
  }) : super(key: key);

  @override
  _RecentDataState createState() => _RecentDataState();
}

class _RecentDataState extends State<RecentData> {
  Future<List<Series>> data = getSeries('public/series');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<Series>> snapshot) {
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
                List<Series>? series = snapshot.data;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: series!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SingleCard(
                    serie: series[index],
                  ),
                );
              }
              return Text('unknown');
            default:
              return Text('data');
          }
        });
  }
}

class SingleCard extends StatelessWidget {
  final Series serie;
  const SingleCard({Key? key, required this.serie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(serie.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            width: size.width * .30,
            height: size.height * .20,
          ),
          Text('${serie.id}'),
        ],
      ),
    );
  }
}
