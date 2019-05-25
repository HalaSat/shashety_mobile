import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'season.g.dart';

abstract class Season implements Built<Season, SeasonBuilder> {
  static Serializer<Season> get serializer => _$seasonSerializer;

  String get id;
  String get title;
  BuiltList<Episode> get episode;

  Season._();

  factory Season([updates(SeasonBuilder b)]) = _$Season;
}

abstract class Episode implements Built<Episode, EpisodeBuilder> {
  static Serializer<Episode> get serializer => _$episodeSerializer;

  String get title;
  String get url;
  String get id;
  String get subtitle;
  String get url360;
  String get url720;

  Episode._();

  factory Episode([updates(EpisodeBuilder b)]) = _$Episode;
}
