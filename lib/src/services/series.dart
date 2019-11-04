import 'dart:async';

import '../services/fetch.dart';
import '../models/serializers.dart';
import '../models/season.dart';
import '../const.dart';

Future<List<Season>> fetchSeries(int id) async {
  List data = await fetch(
    kVoduApiPrefix,
    '/api/seasonsv3/$id',
  );

  List seasons = data;

  for (int i = 0; i < data.length; i++) {
    List episodes = [];
    if (data[i]['episode'] is Map) {
      data[i]['episode'].forEach((key, value) {
        if (key == "-1") {
          return;
        }
        episodes.add(value);
      });
    } else {
      episodes = data[i]['episode'];
    }

    seasons[i]['episode'] = episodes;
  }

  final List<Season> series = seasons
      .map((item) => serializers.deserializeWith(Season.serializer, item))
      .toList();

  return series;
}
