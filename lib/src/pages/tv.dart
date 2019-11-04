import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shashety_mobile/src/widgets/activity_indicator.dart';
import 'package:shashety_mobile/src/widgets/network_error.dart';

import '../widgets/channels_row.dart';
// import '../pages/player.dart';
import '../models/channel.dart';
import '../services/build_channels.dart';
import '../const.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() {
    return _TvPageState();
  }
}

class _TvPageState extends State<TvPage> {
  static final playerChannel = MethodChannel('player-channel');
  bool _channelsLoaded;
  List<Channel> _channels;
  List<String> _categories;

  @override
  void initState() {
    _initChannels();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChannels(context);
  }

  Widget _buildChannels(BuildContext context) {
    if (_channelsLoaded == true) {
      return ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: _categories
              .map((cat) => ChannelsRow(
                    category: cat,
                    onCardPressed: _onCardPressed,
                    channels: _channels,
                  ))
              .toList());
    } else if (_channelsLoaded == false) {
      return buildNetworkError(context, _initChannels);
    } else {
      return Center(
        child: ActivityIndicator(),
      );
    }
  }

  Future<void> _initChannels() async {
    final pageStorageBucket = PageStorage.of(context);
    List<Channel> items;

    try {
      items = pageStorageBucket.readState(context, identifier: 'channels');
      if (items == null) {
        items = await getRawChannelsData(kChannelsUrl);
      }
      final categories = items.map<String>((channel) => channel.category);
      final categoriesSet = Set<String>.from(categories);

      setState(() {
        _categories = categoriesSet.toList();
        _channels = items;
        _channelsLoaded = true;
      });
      pageStorageBucket.writeState(context, _channels, identifier: 'channels');
    } catch (e) {
      print(e);
      setState(() {
        _channelsLoaded = false;
      });
    }
  }

  _onCardPressed(Channel data, BuildContext context) {
    playerChannel.invokeMethod(
        'launchChannelPlayer', {'title': data.name, 'channelUrl': data.url});
  }
}
