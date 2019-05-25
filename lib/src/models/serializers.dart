import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'category.dart';
import 'post.dart';
import 'post_list.dart';
import 'season.dart';
import 'featured.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Post,
  PostList,
  Season,
  Featured,
  Category,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
