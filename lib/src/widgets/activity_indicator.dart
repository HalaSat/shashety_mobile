import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum ActivityIndicatorType { Circular, Linear }

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({ this.type = ActivityIndicatorType.Circular, this.color = Colors.red });

  final ActivityIndicatorType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoActivityIndicator()
          : type == ActivityIndicatorType.Circular
              ? CircularProgressIndicator()
              : LinearProgressIndicator(),
    );
  }
}
