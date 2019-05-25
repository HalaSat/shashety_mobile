import 'dart:async';

import '../services/fetch.dart';
import '../models/serializers.dart';
import '../models/season.dart';
import '../const.dart';

Future<List<Season>> fetchSeries(int id) async {
  final List<dynamic> data = await fetch(
    kVoduApiPrefix,
    '/api/seasonsv3/$id',
  );

  final List<Season> series = data
      .map((item) => serializers.deserializeWith(Season.serializer, item))
      .toList();

  return series;
}
