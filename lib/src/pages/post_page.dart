import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queries/collections.dart';

import '../delegates/post_search.dart';
import '../const.dart';
import '../models/post.dart';
import '../models/post_list.dart';
import '../models/season.dart';
import '../services/vodu.dart';
import '../widgets/activity_indicator.dart';
import '../widgets/post_card.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, @required this.postListItem}) : super(key: key);

  final PostListItem postListItem;

  @override
  _PostPageState createState() {
    return _PostPageState();
  }
}

class _PostPageState extends State<PostPage> {
  static const platform = const MethodChannel('player-channel');

  Future<Post> post;
  List<Season> seasons;

  @override
  void initState() {
    int id = int.parse(widget.postListItem.id);
    PostListItem item = widget.postListItem;

    post = fetchPost(id);

    if (item.type == '1') {
      int id = int.parse(item.id);
      fetchSeries(id).then(
        (data) => setState(() {
          seasons = data;
        }),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).platform == TargetPlatform.android) {
    //   _checkMoviePlayerIsAvailable(context);
    // }

    return Scaffold(
      body: FutureBuilder(
        future: post,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final Post item = snapshot.data;
            final PostListItem movie = item.movies[0];

            return CustomScrollView(
              slivers: <Widget>[
                _buildSliverAppBar(context, movie),
                _buildPageContent(context, movie, item),
              ],
            );
          }
          return ActivityIndicator();
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, PostListItem movie) {
    final genres = movie.genre.split(' / ').toList();
    return SliverAppBar(
      title: Text(movie.title),
      expandedHeight: 250.0,
      floating: true,
      snap: true,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildCoverImageAppBar(movie),
          _buildCoverGradientAppBar(),
          _buildPlayButtonAppBar(movie, context),
          _buildGenresChipsAppBar(genres, context),
        ],
      ),
      actions: <Widget>[
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: PostSearchDelegate(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenresChipsAppBar(List<String> genres, BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Wrap(
          direction: Axis.horizontal,
          children: genres.map((String item) {
            return Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).chipTheme.selectedColor,
              ),
              child: Text(item),
            );
          }).toList()),
    );
  }

  SingleChildRenderObjectWidget _buildPlayButtonAppBar(
      PostListItem movie, BuildContext context) {
    return !(movie.type == '1')
        ? Center(
            child: GestureDetector(
              onTap: () {
                print(movie.url);
                _launchMoviePlayer(movie.title, movie.url, movie.srt);
                // _launchUrl('https://youtu.be/${movie.trailer}');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 80.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
        : SizedBox();
  }

  DecoratedBox _buildCoverGradientAppBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.withOpacity(.2), Colors.blue.withOpacity(.3)],
        ),
      ),
    );
  }

  FadeInImage _buildCoverImageAppBar(PostListItem movie) {
    return FadeInImage(
      height: 300,
      fit: BoxFit.cover,
      image: NetworkImage('$kVoduBase/${movie.background}'),
      placeholder: AssetImage('assets/featured-placeholder.jpg'),
    );
  }

  SliverList _buildPageContent(
      BuildContext context, PostListItem movie, Post item) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _buildTitle(context, movie),
          ExpansionTile(
            title: Column(
              children: <Widget>[
                InfoRow(
                  title: 'Story',
                  data: movie.story,
                ),
              ],
            ),
            children: <Widget>[
              _buildInfoList(context, movie),
            ],
          ),
          seasons != null ? _buildSeasonList(context) : SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Recommended',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              _buildRecommendedRow(context, item),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, PostListItem movie) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 80.0,
            child: Text(
              movie.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Text(
                  movie.imdbrate,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.grey),
                ),
              ),
              Icon(
                Icons.star,
                color: Theme.of(context).accentColor,
                size: Theme.of(context).textTheme.subtitle.fontSize,
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding _buildInfoList(BuildContext context, PostListItem movie) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Column(
        children: <Widget>[
          InfoRow(
            title: 'Year',
            data: movie.year,
          ),
          InfoRow(
            title: 'Category',
            data: movie.category,
          ),
          InfoRow(
            title: 'Genre',
            data: movie.genre,
          ),
          InfoRow(
            title: 'Director',
            data: movie.director,
          ),
          InfoRow(
            title: 'Cast',
            data: movie.cast,
          ),
          InfoRow(
            title: 'Rated',
            data: movie.mpr,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedRow(BuildContext context, Post item) {
    return Container(
      height: 512 / 2.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: item.other.length,
        itemBuilder: (BuildContext context, int index) {
          final PostListItem other = item.other[index];
          return PostCard(
            postListItem: other,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostPage(postListItem: other),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSeasonList(BuildContext context) {
    return Column(
      children: seasons
          .map((Season item) => _buildEpisodeList(context, item))
          .toList(),
    );
  }

  Widget _buildEpisodeList(BuildContext context, Season season) {
    // sort the episodes
    final List<Episode> episodes = season.episode.toList();
    final Collection<Episode> data = Collection<Episode>(episodes);
    final List<Episode> query = data.orderBy((s) => s.title.length).toList();

    return ExpansionTile(
      title: Text(season.title),
      children: query.map((Episode episode) {
        return ListTile(
          title: Text(episode.title),
          onTap: () {
            final String movieUrl = episode.url.isEmpty
                ? episode.url360.isEmpty ? episode.url720 : episode.url360
                : episode.url;
            _launchMoviePlayer(episode.title, movieUrl, episode.subtitle);
          },
        );
      }).toList(),
    );
  }

  void _launchMoviePlayer(String title, String movieUrl, String subtitlesUrl) {
    platform.invokeMethod("launchMoviePlayer", {
      "movieUrl": movieUrl,
      "subtitlesUrl": subtitlesUrl,
      "title": title,
    });
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key key,
    @required this.title,
    @required this.data,
    this.bottomPadding = 5.0,
    this.spaceBetween = 8.0,
  }) : super(key: key);

  final String title;
  final String data;
  final double bottomPadding;
  final double spaceBetween;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: spaceBetween),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).textTheme.caption.color,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Flexible(
            child: Text(data, style: Theme.of(context).textTheme.body1),
          ),
        ],
      ),
    );
  }
}
