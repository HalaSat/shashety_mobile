import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shashety_mobile/src/widgets/activity_indicator.dart';

import '../models/post_list.dart';
import '../pages/post_page.dart';
import '../services/search.dart';
import '../widgets/post_card_vertical.dart';

class PostSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Theme.of(context).platform == TargetPlatform.iOS
            ? CupertinoIcons.back
            : Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchPost(query, ''),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          PostList postList = snapshot.data;
          return ListView.builder(
            itemCount: postList.posts.length,
            itemBuilder: (context, index) {
              PostListItem post = postList.posts[index];

              return PostVerticalCard(
                post: post,
                onPressed: () => _goToPostPage(context, post),
              );
            },
          );
        }
        return ActivityIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Future<PostList> posts =
        query.isEmpty ? searchPost(query, '/page') : searchPost(query, '');
    return FutureBuilder(
      future: posts,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          PostList postList = snapshot.data;

          return ListView.builder(
            itemCount: postList.posts.length,
            itemBuilder: (context, index) {
              PostListItem post = postList.posts[index];

              return ListTile(
                leading: Icon(
                  post.type == '0' ? Icons.movie : Icons.menu,
                ),
                title: Text(post.title),
                onTap: () => _goToPostPage(context, post),
              );
            },
          );
        }
        return ActivityIndicator();
      },
    );
  }

  void _goToPostPage(context, PostListItem post) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PostPage(postListItem: post),
        ),
      );
}
