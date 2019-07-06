import 'package:flutter/material.dart';

typedef OnRetryCallback = Future<void> Function();

Widget buildNetworkError(BuildContext context, OnRetryCallback onRetry) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Can\'t Connect to Shashety',
          style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 20.0),
        ),
        FlatButton(
          child: Text('Retry'),
          onPressed: onRetry,
        ),
      ],
    ),
  );
}
