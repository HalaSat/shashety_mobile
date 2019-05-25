import 'package:flutter/material.dart';

import '../const.dart';
import '../models/channel.dart';

class PlayerChannelCard extends StatelessWidget {
  final Channel data;
  final bool isLastChild;
  final onPressed;

  PlayerChannelCard(
      {@required this.data,
      @required this.onPressed,
      this.isLastChild = false});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image:
                          '$kTvBaseUrl/images/${data.cat}/${data.id}.png.jpg',
                      placeholder: 'assets/placeholder.png',
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      data.name,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w700),
                    )),
              ])),
          onTap: () async {
            onPressed(data, context);
          },
        ));
  }
}
