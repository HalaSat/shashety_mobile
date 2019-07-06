// IMPORTS
import 'package:flutter/material.dart';
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
//    final String title = postListItem.title.length > kTitleMaxLength
//        ? postListItem.title.split('').sublist(0, kTitleMaxLength).join() +
//            '...'
//        : postListItem.title;
//    final String category = postListItem.category.length > kCategoryMaxLength
//        ? postListItem.category
//                .split('')
//                .sublist(0, kCategoryMaxLength)
//                .join() +
//            '...'
//        : postListItem.category;

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
    return FadeInImage(
      height: 297.0,
      fit: BoxFit.cover,
      image: NetworkImage(postListItem.poster),
      placeholder: AssetImage('assets/placeholder.png'),
    );
  }

  // Widget _buildTopInfo(BuildContext context, String title) {
  //   return Container(
  //     padding: const EdgeInsets.only(top: 3.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Text(
  //           title,
  //           textAlign: TextAlign.start,
  //           style: TextStyle(fontSize: 10.0),
  //         ),
  //         Text(
  //           postListItem.year,
  //           style: Theme.of(context).textTheme.caption,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildBottomInfo(BuildContext context, String category) {
  //   TextStyle textStyle = Theme.of(context).textTheme.caption;

  //   return Padding(
  //     padding: const EdgeInsets.only(top: 3.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Text(
  //           category,
  //           style: textStyle,
  //         ),
  //         Row(
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(right: 2.0),
  //               child: Icon(
  //                 Icons.star,
  //                 size: textStyle.fontSize,
  //                 color: Colors.orange,
  //               ),
  //             ),
  //             Text(
  //               postListItem.imdbrate,
  //               style: textStyle,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
