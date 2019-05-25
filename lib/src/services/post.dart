import 'dart:async';

import '../const.dart';
import '../models/serializers.dart';
import '../models/post.dart';
import '../services/fetch.dart';

Future<Post> fetchPost(int id) async {
  final Map<String, dynamic> data = await fetch(
    kVoduApiPrefix,
    '/api/post/$id',
  );
  final Post post = serializers.deserializeWith(Post.serializer, data);

  return post;
}
