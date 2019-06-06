import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';

import '../const.dart';
import '../packages/chewie/lib/chewie.dart';
import '../widgets/channels_row_player.dart';
import '../models/channel.dart';

class PlayerPage extends StatefulWidget {
  final Channel data;
  final List<Channel> channels;
  PlayerPage(this.data, this.channels);

  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  VideoPlayerController _controller;
  ScrollController _scrollController = ScrollController();

  Channel _currentChannel;
  String _name;
  String _category;
  String _url;
  String _imageUrl;
  int _qualityIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentChannel = widget.data;
    _name = widget.data.name;
    _category = widget.data.category;
    _url = widget.data.url;
    _imageUrl =
        '$kTvBaseUrl/images/${widget.data.cat}/${widget.data.id}.png.jpg';
    _controller = VideoPlayerController.network(
      _url,
    );
    Screen.isKeptOn.then((keptOn) {
      if (!keptOn) {
        Screen.keepOn(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),
      body: ListView(controller: _scrollController, children: <Widget>[
        Chewie(
          _controller,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: true,
        ),
        Container(
            margin: EdgeInsets.only(top: 6.0, left: 6.0, bottom: 20.0),
            child: Row(children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(_imageUrl),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Opacity(
                            opacity: .5,
                            child: Row(children: <Widget>[
                              Icon(
                                Icons.category,
                                size: 13,
                              ),
                              Text(
                                _category.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ])),
                      ])),
              Expanded(
                child: Container(),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    value: _qualityIndex,
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Text('AUTO'),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('240p'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('360p'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('720p'),
                      ),
                    ],
                    onChanged: (i) => _setQuality(_currentChannel, i),
                  )))
            ])),
        PlayerChannelsRow(
          category: _category,
          excerpt: 'Recommended',
          icon: Icons.explore,
          onCardPressed: _onCardPressed,
          channels: widget.channels,
          iconColor: Theme.of(context).accentColor,
        ),
      ]),
    );
  }

  void _onCardPressed(Channel channelData, BuildContext context) {
    print('----------\n\n\nchannelData: ' +
        channelData.toString() +
        '-----------\n\n\n');
    String name = channelData.name;
    String category = channelData.category;
    if (channelData.url != _controller.dataSource) {
      setState(() {
        _currentChannel = channelData;
        _name = name;
        print(category);
        _category = category;
        _imageUrl =
            '$kTvBaseUrl/images/${channelData.cat}/${channelData.id}.png.jpg';
        _controller = VideoPlayerController.network(
          channelData.url,
        );
      });
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _setQuality(Channel channel, int value) {
    String url = _getUrls(channel)[value];
    if (url != _controller.dataSource)
      setState(() {
        _controller = VideoPlayerController.network(
          url,
        );
        _qualityIndex = value;
      });
  }

  List<String> _getUrls(Channel item) {
    return [
      item.url,
      item.url360.replaceFirst('360', '240'),
      item.url360,
      item.url720,
    ];
  }
}
