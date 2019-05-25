import 'dart:async';

import '../const.dart';
import '../models/serializers.dart';
import '../models/post_list.dart';
import '../services/fetch.dart';

Future<PostList> fetchPostList(int placeholder, int page) async {
  final Map<String, dynamic> data = await fetch(
    kVoduApiPrefix,
    '/api/list/page/$page',
  );
  final PostList movieList =
      serializers.deserializeWith(PostList.serializer, data);

  return movieList;
}
