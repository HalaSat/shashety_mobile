import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

import '../models/post_list.dart';
import '../pages/post_page.dart';
import '../services/post_list_category.dart';
import '../widgets/activity_indicator.dart';
import '../widgets/post_card_vertical.dart';
import '../widgets/app_bar.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    this.category = 1,
    this.title = 'Recommended',
    this.titleBorderColor = Colors.red,
  });

  final int category;
  final String title;
  final Color titleBorderColor;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<PostListItem> _dataList;

  int _pages;
  int _nextPage = 2;

  @override
  void initState() {
    fetchPostListCategory(widget.category, 1).then(
      (PostList data) => setState(
            () {
              _dataList = data.posts.toList();
              _pages = data.pages;
            },
          ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title),
      body: SafeArea(
        bottom: false,
        child: _dataList != null
            ? _buildList(context, _dataList)
            : Container(
                height: 330.0,
                child: ActivityIndicator(),
              ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<PostListItem> list) {
    return IncrementallyLoadingListView(
      loadMore: _loadMore,
      hasMore: () => (_nextPage <= _pages),
      itemCount: () => list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) =>
          _buildListItem(context, list, index),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    List<PostListItem> list,
    int index,
  ) {
    return PostVerticalCard(
      post: list[index],
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostPage(postListItem: list[index]),
          ),
        );
      },
    );
  }

  Future<bool> _loadMore() async {
    if (_nextPage <= _pages) {
      final PostList data =
          await fetchPostListCategory(widget.category, _nextPage);

      setState(() {
        _dataList.addAll(data.posts);
      });

      _nextPage++;

      return true;
    }
    return false;
  }
}
