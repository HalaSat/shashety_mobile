import 'dart:async';

import '../const.dart';
import '../models/serializers.dart';
import '../models/category.dart';
import '../services/fetch.dart';

Future<List<Category>> fetchCategories() async {
  final List data = (await fetch(
    kVoduApiPrefix,
    '/api/categories',
  ))['cats'];
  final List<Category> categories = data
      .map((item) => serializers.deserializeWith(Category.serializer, item)).toList();

  return categories;
}
