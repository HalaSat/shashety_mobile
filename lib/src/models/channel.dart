import 'package:meta/meta.dart';

class Channel {
  String id;
  String name;
  String url;
  String url360;
  String url720;
  String category;
  String cat;
  bool enabled;

  Channel({@required Map channelData}) {
    id = channelData['id'];
    name = channelData['name'];
    url = channelData['url'];
    url360 = channelData['url_360'];
    url720 = channelData['url_720'];
    category = channelData['category'];
    cat = channelData['cat'];
    enabled = channelData['enabled'];
  }
}
