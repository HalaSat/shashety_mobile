import 'dart:convert';

import 'package:http/http.dart';

import 'package:shashety_mobile/src/models/channel.dart';

Future<List<Channel>> getChannels(String url) async {
  final response = await get(url);

  if (response.statusCode == 200) {
    List data = json.decode(response.body)['channels'];

    List<Channel> channels = data.map<Channel>((channel) {
      return Channel(channelData: channel);
    }).toList();

    return channels;
  }
  throw Exception(response.body);
}
