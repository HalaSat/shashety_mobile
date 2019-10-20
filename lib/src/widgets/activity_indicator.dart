import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum ActivityIndicatorType { Circular, Linear }

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator(
      {this.type = ActivityIndicatorType.Circular, this.color = Colors.red});

  final ActivityIndicatorType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: FlareActor(
          'assets/flare/orb.flr',
          animation: 'Aura',
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
