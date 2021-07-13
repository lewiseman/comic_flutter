import 'package:flutter/material.dart';

class Genre extends StatefulWidget {
  const Genre({
    Key? key,
    required this.genres,
  }) : super(key: key);

  final List genres;

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  List<Widget> genes = [];

  void makeGenes() {
    widget.genres.forEach((element) {
      genes.add(
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('Action'),
        ),
      );
    });
  }

  @override
  void initState() {
    makeGenes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 16),
      child: Wrap(spacing: 12, children: genes),
    );
  }
}
