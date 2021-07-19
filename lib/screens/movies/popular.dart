import 'package:animations/animations.dart';
import 'package:comics/screens/home/movie/single_movie.dart';
import 'package:comics/screens/movies/root.dart';
import 'package:comics/sevices/tmdb/calls.dart';
import 'package:comics/sevices/tmdb/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../root.dart';

class Popular extends StatefulWidget {
  Popular({Key? key}) : super(key: key);

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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
      final List<Movie> newItems = await getMovies('movie/popular', pageKey);
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
    return Container(
      //width: size.width,
      //height: size.height - kToolbarHeight,
      margin: EdgeInsets.only(right: 16),
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedGridView<int, Movie>(
          physics: BouncingScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            animateTransitions: true,
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
