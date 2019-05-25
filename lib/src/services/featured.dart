import 'dart:async';

import '../const.dart';
import '../models/serializers.dart';
import '../models/featured.dart';
import '../services/fetch.dart';

const String kSuffix = '/api/featured';

Future<Featured> fetchFeatured() async {
  final Map<String, dynamic> data = await fetch(
    kVoduApiPrefix,
    kSuffix,
  );
  final Featured movieList =
      serializers.deserializeWith(Featured.serializer, data);

  return movieList;
}
