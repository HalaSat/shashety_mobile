import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'post_list.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  static Serializer<Post> get serializer => _$postSerializer;

  BuiltList<PostListItem> get movies;
  BuiltList<PostListItem> get other;

  Post._();

  factory Post([updates(PostBuilder b)]) = _$Post;
}