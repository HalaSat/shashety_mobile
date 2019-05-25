import 'package:flutter/material.dart';

import '../delegates/post_search.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: <Widget>[
      Builder(
        builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                    context: context,
                    delegate: PostSearchDelegate(),
                  ),
            ),
      ),
    ],
  );
}
