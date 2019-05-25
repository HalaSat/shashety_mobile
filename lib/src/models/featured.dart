import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'featured.g.dart';

abstract class Featured implements Built<Featured, FeaturedBuilder> {
  static Serializer<Featured> get serializer => _$featuredSerializer;
  
  BuiltList<FeaturedItem> get featured;

  Featured._();

  factory Featured([updates(FeaturedBuilder b)]) = _$Featured;
}

abstract class FeaturedItem implements Built<FeaturedItem, FeaturedItemBuilder> {
  static Serializer<FeaturedItem> get serializer => _$featuredItemSerializer;
  
  String get id;
  String get title;
  @nullable
  String get large;
  String get type;

  FeaturedItem._();

  factory FeaturedItem([updates(FeaturedItemBuilder b)]) = _$FeaturedItem;
}