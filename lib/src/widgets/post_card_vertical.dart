import 'package:flutter/material.dart';

import '../const.dart';
import '../models/post_list.dart';

class PostVerticalCard extends StatelessWidget {
  PostVerticalCard({Key key, @required this.post, @required this.onPressed})
      : story = post.story.length > kVCardStoryLength
            ? post.story.substring(0, kVCardStoryLength) + '...'
            : post.story,
        super(key: key);

  final PostListItem post;
  final GestureTapCallback onPressed;
  final String story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          height: 240.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  width: 150.0,
                  height: 240.5,
                  fit: BoxFit.cover,
                  image: NetworkImage(post.poster),
                  placeholder: AssetImage('assets/placeholder.png'),
                ),
              ),
              Container(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.title,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              post.year,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Row(
                              children: [
                                Text(
                                  post.imdbrate,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Icon(
                                  Icons.star,
                                  size: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .fontSize,
                                  color: Theme.of(context).accentColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(story),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
