import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../const.dart';

import '../models/channel.dart';

class ChannelCard extends StatelessWidget {
  ChannelCard({
    @required this.data,
    @required this.onPressed,
    this.isLastChild = false,
  });

  final Channel data;
  final bool isLastChild;
  final onPressed;
  final Color tvColor = Colors.grey[300];
  final Color phoneColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: isLastChild ? 15.0 : 0.0),
      child: InkWell(
        child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  height: 150.0,
                  width: 220.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage(
                    'assets/placeholder.png',
                  ),
                  image: NetworkImage(
                      '$kTvBaseUrl/images/${data.cat}/${data.id}.png.jpg'),
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
        onTap: () {
          onPressed(data, context);
        },
      ),
    );
  }
}
