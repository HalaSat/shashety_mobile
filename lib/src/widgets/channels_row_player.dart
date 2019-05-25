import 'package:flutter/material.dart';

import './channel_card_player.dart';
import '../models/channel.dart';

class PlayerChannelsRow extends StatelessWidget {
  final List<Channel> channels;
  final String category;
  final IconData icon;
  final String excerpt;
  final Color iconColor;
  final onCardPressed;

  // filter channels by category
  static List<Channel> filterChannels(String cat, List<Channel> channels) {
    List<Channel> items =
        channels.where((Channel item) => item.cat == cat).toList();
    return items.isNotEmpty ? items : channels;
  }

  PlayerChannelsRow({
    @required this.category,
    @required this.excerpt,
    @required this.icon,
    @required this.channels,
    @required this.onCardPressed,
    this.iconColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    List<Channel> items = filterChannels(category, channels);
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 18.0,
                  ),
                ),
                Text(
                  excerpt,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    // color: iconColor
                  ),
                )
              ])),
          Container(
            height: 173.0,
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                bool isLastChild = items.length == index + 1;
                return PlayerChannelCard(
                  data: items[index],
                  isLastChild: isLastChild,
                  onPressed: (data, context) => onCardPressed(data, context),
                );
              },
            ),
          ),
          // Divider(),
        ],
      ),
    );
  }
}
