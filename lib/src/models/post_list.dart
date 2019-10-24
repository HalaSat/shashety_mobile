import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'post_list.g.dart';

abstract class PostList implements Built<PostList, PostListBuilder> {
  static Serializer<PostList> get serializer => _$postListSerializer;

  BuiltList<PostListItem> get posts;
  int get pages;

  PostList._();

  factory PostList([updates(PostListBuilder b)]) = _$PostList;
}

abstract class PostListItem
    implements Built<PostListItem, PostListItemBuilder> {
  static Serializer<PostListItem> get serializer => _$postListItemSerializer;

  String get id;
  String get title;
  String get story;
  String get poster;
  String get type;
  String get year;
  @nullable
  String get trailer;
  @nullable
  String get views;
  String get imdbrate;
  @nullable
  String get mpr;
  @nullable
  String get seasons;
  @nullable
  String get category;
  @nullable
  String get serverip;
  @nullable
  String get url;
  @nullable
  String get urladaptive;
  @nullable
  String get url360;
  @nullable
  String get url720;
  @nullable
  String get webvtt;
  @nullable
  String get background;
  @nullable
  String get cast;
  @nullable
  String get director;
  // Only the post -> other has a genre field
  @nullable
  String get genre;
  // Only post -> movies has a srt field
  @nullable
  String get srt;

  PostListItem._();

  factory PostListItem([updates(PostListItemBuilder b)]) = _$PostListItem;
}
