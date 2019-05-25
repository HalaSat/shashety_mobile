import 'dart:async';

import '../const.dart';
import '../models/serializers.dart';
import '../models/post_list.dart';
import '../services/fetch.dart';

Future<PostList> searchPost(String query, String suffix) async {
  final Map<String, dynamic> data = await fetch(
    kVoduApiPrefix,
    '/api/list/search/$query$suffix',
  );

  final PostList postList =
      serializers.deserializeWith(PostList.serializer, data);

  return postList;
}
