import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category.g.dart';

abstract class Category implements Built<Category, CategoryBuilder> {
  static Serializer<Category> get serializer => _$categorySerializer;

  String get id;
  String get title;
  @nullable
  String get badquality;
  @nullable
  String get type;
  @nullable
  String get vorder;
  @nullable
  String get imdb;
  @nullable
  String get elcinema;
  @nullable
  String get parent;

  Category._();

  factory Category([updates(CategoryBuilder b)]) = _$Category;
}
