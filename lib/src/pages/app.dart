import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shashety_mobile/src/models/account.dart';
import 'package:shashety_mobile/src/services/auth.dart';
import 'package:shashety_mobile/src/widgets/activity_indicator.dart';

import '../delegates/post_search.dart';
import '../const.dart';
import '../models/category.dart';
import '../models/featured.dart';
import '../models/post.dart';
import '../pages/post_page.dart';
import '../services/categories.dart';
import '../services/featured.dart';
import '../services/post.dart';
import '../services/post_list_category.dart';
import '../widgets/post_row.dart';
import 'tv.dart';
import 'login.dart';

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
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.purple];
  // Color _appBarColor;
  List<Widget> _tabs = [];
  int _currentTab = 0;

  @override
  void initState() {
    _tabs.add(PageStorage(bucket: bucket, child: HomePage()));
    _tabs.add(_createPageStorage(TvPage()));
    _tabs.add(_createPageStorage(LoginPage()));

    // _appBarColor = _colors[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: _appBarColor,
          centerTitle: true,
          title: Text(kAppName),
          leading: ScopedModelDescendant<AccountModel>(
            builder: (BuildContext context, Widget _, AccountModel account) {
              return account.status == AccountStatus.signedIn
                  ? IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        _auth.signOut().then((void v) {
                          account.status = AccountStatus.signedOut;
                        });
                      },
                    )
                  : SizedBox();
            },
          ),
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
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentTab,
          onTap: (index) => setState(() {
                _currentTab = index;
                // _appBarColor = _colors[index];
              }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                title: Text('Cinema'),
                backgroundColor: _colors[0]),
            BottomNavigationBarItem(
                icon: Icon(Icons.tv),
                title: Text('TV'),
                backgroundColor: _colors[1]),
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text('Chat'),
                backgroundColor: _colors[2])
          ],
        ),
        body: _tabs[_currentTab],
      ),
    );
  }

  Widget _createPageStorage(Widget widget) =>
      PageStorage(bucket: bucket, child: widget);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _categories;
  Featured _featured;
  bool _hasError;

  @override
  void initState() {
    super.initState();

    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _hasError != null
          ? _hasError == false
              ? ListView(children: [
                  _buildCarouselSlider(context),
                  _buildCategories(context),
                ])
              : _buildNetworkError(context)
          : ActivityIndicator(),
      onRefresh: _refreshMovies,
    );
  }

  Future<void> _refreshMovies() async {
    setState(() {
      _hasError = null;
      _categories = null;
      _featured = null;
    });
    _getMovies();
  }

  Future<void> _getMovies() async {
    List<Category> categories =
        PageStorage.of(context).readState(context, identifier: 'categories');
    Featured featured =
        PageStorage.of(context).readState(context, identifier: 'featured');
    print(
        '-----------------------------------------------------------------------------\n ${categories != null && featured != null}\n---------------------------------------------------------------------------------------------------------');
    if (categories != null) {
      print(
          '---------------------------------------------------------------------------\nfeatured != null && categories != null\n---------------------------------------------------------------------------------------------------------');
      setState(() {
        _hasError = false;
        _categories = categories;
        _featured = featured;
      });
    } else {
      try {
        final List<Category> cats = await fetchCategories();
        if (cats != null) {
          final Featured feat = await fetchFeatured();
          setState(() {
            _hasError = false;
            _categories = cats;
            _featured = feat;
          });
          PageStorage.of(context)
              .writeState(context, _categories, identifier: 'categories');
          PageStorage.of(context)
              .writeState(context, _featured, identifier: 'featured');
        }
      } catch (error) {
        setState(() => _hasError = true);
      }
    }
  }

  Widget _buildCarouselSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: _featured != null
          ? CarouselSlider(
              autoPlay: true,
              height: 200.0,
              items: _featured.featured.map(
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.red.withOpacity(0.5),
                    Colors.blue.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Text(
                item.title,
                style: TextStyle(fontSize: 15.0),
              ),
            )
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
    return _categories != null
        ? Column(
            children: _categories
                .where((Category item) {
                  return item.id != '13';
                })
                .map<Widget>(
                  (Category item) => PostRow(
                        title: item.title,
                        titleBorderColor: Theme.of(context).accentColor,
                        fetchList: fetchPostListCategory,
                        category: int.parse(item.id),
                      ),
                )
                .toList(),
          )
        : SizedBox();
  }

  Widget _buildNetworkError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _getMovies(),
          ),
          Text('Connection error, please try again.'),
        ],
      ),
    );
  }
}
