import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import '../models/post_list.dart';

import 'category.dart';
import 'featured.dart';

part 'home_page_movies.g.dart';


abstract class HomePageMovies implements Built<HomePageMovies, HomePageMoviesBuilder> {
  static Serializer<HomePageMovies> get serializer => _$homePageMoviesSerializer;

  Featured get featured;
  BuiltList<Category> get categories;
  BuiltMap<String, PostList> get movies;

  HomePageMovies._();

  factory HomePageMovies([update(HomePageMoviesBuilder b)]) = _$HomePageMovies;
}