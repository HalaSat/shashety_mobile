import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shashety_mobile/src/services/categories.dart';

import '../models/account.dart';
import '../models/home_page_movies.dart';
import '../services/auth.dart';
import '../widgets/activity_indicator.dart';
import '../services/home_page_movies.dart';
import '../delegates/post_search.dart';
import '../const.dart';
import '../models/category.dart';
import '../models/featured.dart';
import '../models/post.dart';
import '../pages/post_page.dart';
import '../services/post.dart';
import '../widgets/post_row.dart';
import 'category.dart';
import 'tv.dart';
import 'login.dart';
import '../widgets/network_error.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: _buildTheme(),
      home: Body(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      scaffoldBackgroundColor: Colors.black,
    );
  }
}

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Auth _auth = Auth();
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.indigo];
  List<Widget> _tabs = [];
  int _currentTab = 0;

  @override
  void initState() {
    _tabs.add(_createPageStorage(HomePage()));
    _tabs.add(_createPageStorage(TvPage()));
    _tabs.add(_createPageStorage(LoginPage()));

    // _appBarColor = _colors[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(kAppName.toUpperCase()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: PostSearchDelegate(),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple[400],
        currentIndex: _currentTab,
        onTap: (index) => setState(() {
          _currentTab = index;
          // _appBarColor = _colors[index];
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Cinema'),
            backgroundColor: _colors[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            title: Text('TV'),
            backgroundColor: _colors[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Chat'),
            backgroundColor: _colors[2],
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ScopedModelDescendant<AccountModel>(
            builder: (BuildContext context, Widget _, AccountModel account) {
              return account.status == AccountStatus.signedIn
                  ? ListView(
                      children: [
                        SizedBox(height: 10.0),
                        Align(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(account.user.photoUrl),
                            radius: 40.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          account.user.displayName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: 20.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          account.user.email,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: OutlineButton(
                            textColor: Colors.red,
                            highlightedBorderColor: Colors.red,
                            child: Text('LOGOUT'),
                            onPressed: () async {
                              await _auth.signOut();
                              account.status = AccountStatus.signedOut;
                            },
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 5.0),
                        FutureBuilder(
                          future: fetchCategories(),
                          builder: (context,
                              AsyncSnapshot<List<Category>> snapshot) {
                            if (snapshot.hasData) {
                              return _buildCategoryList(context, snapshot.data);
                            }
                            return SizedBox();
                          },
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login to View Your Profile',
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.indigo,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _currentTab = 2;
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
      body: IndexedStack(index: _currentTab, children: _tabs),
    );
  }

  Widget _buildCategoryList(context, List<Category> cats) => Container(
        // height: double.infinity,
        child: Column(
          children: cats
              .map((item) => ListTile(
                    title: Text(item.title,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CategoryPage(
                              category: int.parse(item.id), title: item.title);
                        }),
                      );
                    },
                  ))
              .toList(),
        ),
      );

  Widget _createPageStorage(Widget widget) =>
      PageStorage(bucket: bucket, child: widget);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePageMovies _homePageMovies;
  bool _hasError;
  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return _hasError != null
        ? !_hasError
            ? FadeTransition(
                opacity: _animation,
                child: ListView(children: [
                  _buildCarouselSlider(context),
                  _buildCategories(context),
                ]))
            : buildNetworkError(context, _getMovies)
        : ActivityIndicator();
  }

  void _startAnimation() => _animation.forward();

  Future<void> _getMovies() async {
    setState(() {
      _hasError = null;
    });
    HomePageMovies homePageMovies = PageStorage.of(context)
        .readState(context, identifier: 'homepagemovies');

    if (homePageMovies != null) {
      setState(() {
        _hasError = false;
        _homePageMovies = homePageMovies;
      });
      _startAnimation();
    } else {
      getHomePageMovies().then((data) {
        setState(() {
          _homePageMovies = data;
          _hasError = false;
        });
        PageStorage.of(context)
            .writeState(context, _homePageMovies, identifier: 'homepagemovies');
        _startAnimation();
      }).catchError((error) => setState(() {
            _hasError = true;
          }));
    }
  }

  Widget _buildCarouselSlider(BuildContext context) {
    final featured = _homePageMovies.featured;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: featured != null
          ? CarouselSlider(
              autoPlay: true,
              height: 200.0,
              items: featured.featured.map(
                (FeaturedItem item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return _buildFeaturedPost(context, item);
                    },
                  );
                },
              ).toList(),
            )
          : SizedBox(),
    );
  }

  Widget _buildFeaturedPost(BuildContext context, FeaturedItem item) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/featured-placeholder.jpg'),
              image: NetworkImage(
                '$kVoduBase/${item.large}',
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: <Color>[
            //         Colors.red.withOpacity(0.5),
            //         Colors.blue.withOpacity(0.3),
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 10.0,
            //   left: 10.0,
            //   child: Text(
            //     item.title,
            //     style: TextStyle(fontSize: 15.0),
            //   ),
            // )
          ],
        ),
      ),
      onTap: () async {
        Post res = await fetchPost(int.parse(item.id));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return PostPage(
                postListItem: res.movies[0],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = _homePageMovies.categories;
    return categories != null
        ? Column(
            children: categories
                .where((Category item) {
                  return item.id != '13';
                })
                .map<Widget>(
                  (Category category) => PostRow(
                    title: category.title,
                    titleBorderColor: Theme.of(context).accentColor,
                    data: _homePageMovies.movies[category.title],
                    category: int.parse(category.id),
                  ),
                )
                .toList(),
          )
        : SizedBox();
  }
}
