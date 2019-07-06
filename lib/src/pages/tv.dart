import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Screen.isKeptOn.then((keptOn) {
      if (keptOn) {
        Screen.keepOn(false);
      }
    });

    _initChannels();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await _getChannels();
        },
        child: _buildChannels(context));
  }

  Widget _buildChannels(BuildContext context) {
    if (_channelsLoaded == true) {
      return ListView(
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          ChannelsRow(
            category: 'sport',
            excerpt: 'Sport',
            icon: Icons.directions_run,
            onCardPressed: _onCardPressed,
            iconColor: Colors.green,
            channels: _channels,
          ),
          ChannelsRow(
            category: 'enter',
            excerpt: 'Entertainment',
            icon: Icons.featured_video,
            onCardPressed: _onCardPressed,
            iconColor: Colors.orange,
            channels: _channels,
          ),
          ChannelsRow(
            category: 'movies',
            excerpt: 'Movies',
            icon: Icons.movie,
            onCardPressed: _onCardPressed,
            iconColor: Colors.red,
            channels: _channels,
          ),
          ChannelsRow(
            category: 'series',
            excerpt: 'Series',
            icon: Icons.movie,
            onCardPressed: _onCardPressed,
            iconColor: Colors.purple,
            channels: _channels,
          ),
          ChannelsRow(
            category: 'kids',
            excerpt: 'Kids',
            icon: Icons.child_care,
            onCardPressed: _onCardPressed,
            iconColor: Colors.pink,
            channels: _channels,
          ),
        ],
      );
    } else if (_channelsLoaded == false) {
      return buildNetworkError(context, _getChannels);
    } else {
      return Center(
        child: ActivityIndicator(),
      );
    }
  }

  Future<void> _getChannels() async {
    setState(() {
      _channels = null;
      _channelsLoaded = null;
    });
    try {
      final channels = await getRawChannelsData(kChannelsUrl);
      setState(() {
        _channels = channels;
        _channelsLoaded = true;
      });
      PageStorage.of(context)
          .writeState(context, _channels, identifier: 'channels');
    } catch (error) {
      setState(() {
        _channelsLoaded = false;
      });
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
      setState(() {
        _channels = items;
        _channelsLoaded = true;
      });
      pageStorageBucket.writeState(context, _channels, identifier: 'channels');
    } catch (e) {
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
