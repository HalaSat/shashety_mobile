import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/home_page_movies.dart';

import '../const.dart';
import '../models/category.dart';
import '../models/serializers.dart';

Future<HomePageMovies> getHomePageMovies() async {
  final client = http.Client();
  try {
    // Featured
    final featuredUrl = '$kVoduApiPrefix/api/featured';
    final featuredResponse =
        await client.get(featuredUrl).timeout(Duration(seconds: 15));
    final featuredData = jsonDecode(featuredResponse.body);

    // Categories
    final categoriesUrl = '$kVoduApiPrefix/api/categories';
    final categoriesResponse = await client.get(categoriesUrl);
    final categoriesData = jsonDecode(categoriesResponse.body)['cats'];
    final categories = List<Category>.from(categoriesData
        .map((item) => serializers.deserializeWith(Category.serializer, item)));

    // PostList
    final postListUrl = '$kVoduApiPrefix/api/list/category';

    // Hold the post list data for each category
    final moviesData = {};

    // Loop through the categories and add each post list
    for (final category in categories) {
      final postsResponse = await client.get('$postListUrl/${category.id}');
      final postsData = jsonDecode(postsResponse.body);

      moviesData[category.title] = postsData;
    }

    // Deserialize home page movies
    final homePageMovies =
        serializers.deserializeWith(HomePageMovies.serializer, {
      'featured': featuredData,
      'categories': categoriesData,
      'movies': moviesData,
    });

    return homePageMovies;
  } finally {
    client.close();
  }
}
