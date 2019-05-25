import 'dart:async';

import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:shashety_cinema_mobile/src/widgets/activity_indicator.dart';

import '../widgets/channels_row.dart';
import '../pages/player.dart';
import '../models/channel.dart';
import '../services/build_channels.dart';
import '../const.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() {
    return _TvPageState();
  }
}

class _TvPageState extends State<TvPage>
    with AfterLayoutMixin<TvPage>, AutomaticKeepAliveClientMixin {
  bool isFirst = true;
  bool recentChannelsSet = false;
  List<Channel> _channels;
  List<Channel> _recentChannels = [];
  List<FocusNode> _nodesList;
  FocusNode inFocus;
  int inFocusIndex;
  int inFocusCardIndex = 0;
  Channel inFocusChannelRef;
  FocusNode recentNode;
  FocusNode sportNode;
  FocusNode entertainmentNode;
  FocusNode moviesNode;
  FocusNode kidsNode;
  FocusNode musicNode;
  ScrollController cont;
  int inFocusRowCardsNumber;
  double rowHeight = 260;
  GlobalKey key;
  List<ScrollController> scrollControllers = [];
  PersistentBottomSheetController _bottomSheetController;
  bool _channelsLoaded;

  @override
  void dispose() {
    _bottomSheetController.close();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setChannels(context).then((result) {
      if (result) {
        _nodesList.insert(0, recentNode);
      }
      if (isFirst) {
        FocusScope.of(context).requestFocus(_nodesList.first);
        inFocusIndex = _nodesList.indexOf(_nodesList.first);
        isFirst = false;
      }
    });
  }

  @override
  void initState() {
    cont = ScrollController();
    key = GlobalKey();

    _nodesList = List<FocusNode>();
    recentNode = FocusNode();
    sportNode = FocusNode();
    entertainmentNode = FocusNode();
    moviesNode = FocusNode();
    kidsNode = FocusNode();
    musicNode = FocusNode();

    _nodesList.add(sportNode);
    _nodesList.add(entertainmentNode);
    _nodesList.add(moviesNode);
    _nodesList.add(kidsNode);
    _nodesList.add(musicNode);

    // Initializing Scroll Controllers
    for (var i = 0; i <= 5; i++) {
      ScrollController temp = ScrollController();
      scrollControllers.add(temp);
    }
    Screen.isKeptOn.then((keptOn) {
      if (keptOn) {
        Screen.keepOn(false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await _setChannels(context);
        },
        child: _buildChannels(context));
  }

  Widget _buildChannels(BuildContext context) {
    if (_channelsLoaded == true)
      return ListView(
        cacheExtent: _nodesList.length * rowHeight,
        controller: cont,
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          RawKeyboardListener(
            key: key,
            child: ChannelsRow(
              setCardsNumber: setCardsNumber,
              category: 'sport',
              excerpt: 'Sport',
              icon: Icons.directions_run,
              onCardPressed: _onCardPressed,
              iconColor: Colors.green,
              channels: _channels,
              rowHasFocus:
                  inFocusIndex == _nodesList.indexOf(_nodesList.last) - 4
                      ? true
                      : false,
              scrollController: _recentChannels.isEmpty
                  ? scrollControllers[0]
                  : scrollControllers[1],
              inFocusCardIndex: inFocusCardIndex,
              cardPhysicalKeyListener: onKeyboardEvent,
              setFocusedChannel: setInFocusChannel,
            ),
            focusNode: _recentChannels.isEmpty ? _nodesList[0] : _nodesList[1],
            onKey: onKeyboardEvent,
          ),
          RawKeyboardListener(
            child: ChannelsRow(
              setCardsNumber: setCardsNumber,
              category: 'enter',
              excerpt: 'Entertainment',
              icon: Icons.featured_video,
              onCardPressed: _onCardPressed,
              iconColor: Colors.orange,
              channels: _channels,
              rowHasFocus:
                  inFocusIndex == _nodesList.indexOf(_nodesList.last) - 3
                      ? true
                      : false,
              inFocusCardIndex: inFocusCardIndex,
              scrollController: _recentChannels.isEmpty
                  ? scrollControllers[1]
                  : scrollControllers[2],
              cardPhysicalKeyListener: onKeyboardEvent,
              setFocusedChannel: setInFocusChannel,
            ),
            focusNode: _recentChannels.isEmpty ? _nodesList[1] : _nodesList[2],
            onKey: onKeyboardEvent,
          ),
          RawKeyboardListener(
            child: ChannelsRow(
              setCardsNumber: setCardsNumber,
              category: 'movies',
              excerpt: 'Movies',
              icon: Icons.movie,
              onCardPressed: _onCardPressed,
              iconColor: Colors.red,
              channels: _channels,
              rowHasFocus:
                  inFocusIndex == _nodesList.indexOf(_nodesList.last) - 2
                      ? true
                      : false,
              inFocusCardIndex: inFocusCardIndex,
              scrollController: _recentChannels.isEmpty
                  ? scrollControllers[2]
                  : scrollControllers[3],
              cardPhysicalKeyListener: onKeyboardEvent,
              setFocusedChannel: setInFocusChannel,
            ),
            focusNode: _recentChannels.isEmpty ? _nodesList[2] : _nodesList[3],
            onKey: onKeyboardEvent,
          ),
          RawKeyboardListener(
            child: ChannelsRow(
              setCardsNumber: setCardsNumber,
              category: 'series',
              excerpt: 'Series',
              icon: Icons.movie,
              onCardPressed: _onCardPressed,
              iconColor: Colors.purple,
              channels: _channels,
              rowHasFocus:
                  inFocusIndex == _nodesList.indexOf(_nodesList.last) - 2
                      ? true
                      : false,
              inFocusCardIndex: inFocusCardIndex,
              scrollController: _recentChannels.isEmpty
                  ? scrollControllers[3]
                  : scrollControllers[4],
              cardPhysicalKeyListener: onKeyboardEvent,
              setFocusedChannel: setInFocusChannel,
            ),
            focusNode: _recentChannels.isEmpty ? _nodesList[2] : _nodesList[3],
            onKey: onKeyboardEvent,
          ),
          RawKeyboardListener(
            child: ChannelsRow(
              setCardsNumber: setCardsNumber,
              category: 'kids',
              excerpt: 'Kids',
              icon: Icons.child_care,
              onCardPressed: _onCardPressed,
              iconColor: Colors.pink,
              channels: _channels,
              rowHasFocus:
                  inFocusIndex == _nodesList.indexOf(_nodesList.last) - 1
                      ? true
                      : false,
              scrollController: _recentChannels.isEmpty
                  ? scrollControllers[4]
                  : scrollControllers[5],
              inFocusCardIndex: inFocusCardIndex,
              cardPhysicalKeyListener: onKeyboardEvent,
              setFocusedChannel: setInFocusChannel,
            ),
            focusNode: _recentChannels.isEmpty ? _nodesList[3] : _nodesList[4],
            onKey: onKeyboardEvent,
          ),
        ],
      );
    else if (_channelsLoaded == false)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _setChannels(context),
            ),
            Text('Connection error, please try again.')
          ],
        ),
      );
    else
      return Center(
        child: ActivityIndicator(),
      );
  }

  Future<bool> _setChannels(BuildContext context) async {
    List<Channel> items;
    setState(() {
      _channelsLoaded = null;
    });
    try {
      items = await getRawChannelsData(kChannelsUrl);
      // result = await _setRecentChannels(items);
      setState(() {
        _channels = items;
        _channelsLoaded = true;
      });
    } catch (e) {
      setState(() {
        _channelsLoaded = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('You are offline, or not a subscriber of HalaSat'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }

    return false;
  }

  _onCardPressed(Channel data, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PlayerPage(data, _channels)));
  }

  void onKeyboardEvent(RawKeyEvent event) {
    RenderBox box = key.currentContext.findRenderObject();
    rowHeight = box.size.height;
    FocusNode requestingNode = FocusNode();
    if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
      RawKeyDownEvent ev = event;
      RawKeyEventDataAndroid evAndroid = ev.data;
      if (evAndroid.keyCode == 20) {
        if (_nodesList.last == inFocus) {
          requestingNode = _nodesList
              .first; //_recentChannels.isNotEmpty ? _nodesList.first : _nodesList[_nodesList.indexOf(_nodesList.first) + 1];
          cont.animateTo(rowHeight * _nodesList.indexOf(_nodesList.first),
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
          inFocus = requestingNode;
        } else {
          requestingNode = _nodesList[_nodesList.indexOf(inFocus) + 1];
          cont.animateTo(rowHeight * _nodesList.indexOf(requestingNode),
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
          inFocus = requestingNode;
        }
        FocusScope.of(context).requestFocus(requestingNode);
        setState(() {
          inFocusIndex = _nodesList.indexOf(requestingNode);
          inFocusCardIndex = 0;
          scrollControllers[inFocusIndex].animateTo(0.0,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        });
      } else if (evAndroid.keyCode == 19) {
        if (_nodesList.first == inFocus) {
          requestingNode = _nodesList.last;
          cont.animateTo(rowHeight * _nodesList.indexOf(requestingNode),
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
          inFocus = requestingNode;
        } else {
          requestingNode = _nodesList[_nodesList.indexOf(inFocus) - 1];
          cont.animateTo(rowHeight * _nodesList.indexOf(requestingNode),
              duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
          inFocus = requestingNode;
        }

        FocusScope.of(context).requestFocus(requestingNode);
        setState(() {
          inFocusIndex = _nodesList.indexOf(requestingNode);
          inFocusCardIndex = 0;
          scrollControllers[inFocusIndex].animateTo(0.0,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        });
      } else if (evAndroid.keyCode == 22) {
        if (inFocusCardIndex == inFocusRowCardsNumber) {
        } else if (inFocusCardIndex < inFocusRowCardsNumber) {
          inFocusCardIndex = inFocusCardIndex + 1;
          scrollControllers[inFocusIndex].animateTo(150.0 * inFocusCardIndex,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          setState(() {});
        }
      } else if (evAndroid.keyCode == 21) {
        if (inFocusCardIndex == 0) {
        } else if (inFocusCardIndex > 0) {
          inFocusCardIndex = inFocusCardIndex - 1;
          scrollControllers[inFocusIndex].animateTo(150.0 * inFocusCardIndex,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        }
        setState(() {});
      } else if (evAndroid.keyCode == 23) {
        _onCardPressed(inFocusChannelRef, context);
      }
    }
  }

  void setCardsNumber(int value) {
    inFocusRowCardsNumber = value - 1;
  }

  void setInFocusChannel(Channel ch) {
    inFocusChannelRef = ch;
  }

  @override
  bool get wantKeepAlive => true;
}
