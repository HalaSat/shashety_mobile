import 'package:meta/meta.dart';

class Channel {
  String id;
  String name;
  String url;
  String category;
  String image;
  bool enabled;

  Channel({@required Map channelData}) {
    id = channelData['id'];
    name = channelData['name'];
    url = channelData['url'];
    category = channelData['category'];
    image = channelData['image'];
    enabled = channelData['enabled'];
  }
}
