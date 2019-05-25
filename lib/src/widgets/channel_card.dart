import 'package:flutter/material.dart';
import '../const.dart';

import '../models/channel.dart';

class ChannelCard extends StatelessWidget {
  final Channel data;
  final bool isLastChild;
  final onPressed;
  final bool hasFocus;
  final Color tvColor = Colors.grey[300];
  final Color phoneColor = Colors.transparent;

  ChannelCard({
    @required this.data,
    @required this.onPressed,
    this.hasFocus = false,
    this.isLastChild = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    Color appliedColor = screenSize < 960.0 ? phoneColor : tvColor;
    return Container(
        decoration:
            BoxDecoration(color: hasFocus ? appliedColor : Colors.transparent),
        margin: EdgeInsets.only(left: 15.0, right: isLastChild ? 15.0 : 0.0),
        child: InkWell(
          // radius: 10.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                    height: 150.0,
                    width: 220.0,
                    fit: BoxFit.cover,
                    image: '$kTvBaseUrl/images/${data.cat}/${data.id}.png.jpg',
                    placeholder: 'assets/placeholder.png',
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ])),
          onTap: () async {
            onPressed(data, context);
          },
        ));
  }
}
