// IMPORTS
import 'package:flutter/material.dart';
import '../const.dart';
import '../models/post_list.dart';

// CONSTANTS
const int kTitleMaxLength = 15;
const int kCategoryMaxLength = 12;

typedef void OnTapCallback();

// WIDGETS
class PostCard extends StatelessWidget {
  PostCard({Key key, @required this.postListItem, @required this.onPressed})
      : assert(postListItem != null),
        super(key: key);

  final PostListItem postListItem;
  final OnTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: postListItem.title,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: 320 / 2.5,
        child: InkWell(
          child: _buildPoster(context),
          onTap: onPressed,
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    String poster;
    if (postListItem.poster.startsWith('http')) {
      poster = postListItem.poster;
    } else {
      poster = kVoduBase + '/' + postListItem.poster;
    }
    return FadeInImage(
      height: 297.0,
      fit: BoxFit.cover,
      image: NetworkImage(poster),
      placeholder: AssetImage('assets/placeholder.png'),
    );
  }
}
