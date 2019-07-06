import 'dart:async';

import 'package:flutter/material.dart';
import '../pages/category.dart';

import '../models/post_list.dart';
import '../pages/post_page.dart';
import '../widgets/post_card.dart';

typedef Future<PostList> FetchList(int category, int page);

class PostRow extends StatefulWidget {
  const PostRow({
    this.data,
    this.category = 1,
    this.title = 'Recommended',
    this.titleBorderColor = Colors.red,
  });

  final PostList data;
  final int category;
  final String title;
  final Color titleBorderColor;

  @override
  _PostRowState createState() => _PostRowState();
}

class _PostRowState extends State<PostRow> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
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
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: _buildList(
        context,
        widget.data.posts.toList(),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<PostListItem> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
          onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return CategoryPage(
                    category: widget.category,
                    title: widget.title,
                    titleBorderColor: widget.titleBorderColor,
                  );
                }),
              ),
        ),
        Container(
          height: 512 / 2.5,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) =>
                _buildListItem(context, list, index),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context,
    List<PostListItem> list,
    int index,
  ) {
    return PostCard(
      postListItem: list[index],
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostPage(postListItem: list[index]),
          ),
        );
      },
    );
  }
}
