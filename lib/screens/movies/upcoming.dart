import 'package:animations/animations.dart';
import 'package:comics/screens/home/movie/single_movie.dart';
import 'package:comics/screens/movies/root.dart';
import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../root.dart';

class Upcoming extends StatefulWidget {
  Upcoming({Key? key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  static const _pageSize = 20;
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Movie> newItems = await getMovies('movie/upcoming', pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Upcoming'),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 16),
        child: PagedGridView<int, Movie>(
          physics: BouncingScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, item, index) => OpenContainer(
              middleColor: bgColor,
              closedColor: bgColor,
              openColor: bgColor,
              closedBuilder: (context, close) => SingleMovieGrid(
                movie: item,
                size: size,
              ),
              openBuilder: (context, open) => SingleMoviePage(
                movie: item,
              ),
            ),
            firstPageProgressIndicatorBuilder: (_) =>
                CupertinoActivityIndicator(),
            newPageProgressIndicatorBuilder: (_) =>
                CupertinoActivityIndicator(),
            noMoreItemsIndicatorBuilder: (_) => Text('no more items'),
            newPageErrorIndicatorBuilder: (_) => Text('new page error !'),
            firstPageErrorIndicatorBuilder: (_) => Text('first page error !'),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
