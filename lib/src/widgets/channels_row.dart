import 'package:flutter/material.dart';

import './channel_card.dart';
import '../models/channel.dart';

class ChannelsRow extends StatefulWidget {
  ChannelsRow({
    @required this.category,
    @required this.excerpt,
    @required this.icon,
    @required this.channels,
    @required this.onCardPressed,
    this.iconColor = Colors.blue,
  });

  final List<Channel> channels;
  final String category;
  final IconData icon;
  final String excerpt;
  final Color iconColor;
  final onCardPressed;

  @override
  State<StatefulWidget> createState() {
    return ChannelsRowState();
  }
}

class ChannelsRowState extends State<ChannelsRow> {
  final List<Channel> items = [];

  @override
  void initState() {
    filterChannels(widget.category, widget.channels, items);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.0, bottom: 5.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 18.0,
                  ),
                ),
                Text(
                  widget.excerpt,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 173.0,
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: ListView.builder(
              cacheExtent: 150.0 * items.length,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                bool isLastChild = items.length == index + 1;
                return ChannelCard(
                  data: items[index],
                  isLastChild: isLastChild,
                  onPressed: (data, context) =>
                      widget.onCardPressed(data, context),
                );
              },
            ),
          ),
          // Divider(),
        ],
      ),
    );
  }

  // Filter channels by category
  filterChannels(
      String cat, List<Channel> channels, List<Channel> filteredItems) {
    List<Channel> items =
        channels.where((Channel item) => item.cat == cat).toList();
    items = items.isNotEmpty ? items : channels;
    filteredItems.addAll(items);
  }
}
