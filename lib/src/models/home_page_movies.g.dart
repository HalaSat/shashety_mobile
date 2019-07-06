// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_movies.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HomePageMovies> _$homePageMoviesSerializer =
    new _$HomePageMoviesSerializer();

class _$HomePageMoviesSerializer
    implements StructuredSerializer<HomePageMovies> {
  @override
  final Iterable<Type> types = const [HomePageMovies, _$HomePageMovies];
  @override
  final String wireName = 'HomePageMovies';

  @override
  Iterable serialize(Serializers serializers, HomePageMovies object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'featured',
      serializers.serialize(object.featured,
          specifiedType: const FullType(Featured)),
      'categories',
      serializers.serialize(object.categories,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Category)])),
      'movies',
      serializers.serialize(object.movies,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(PostList)])),
    ];

    return result;
  }

  @override
  HomePageMovies deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HomePageMoviesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'featured':
          result.featured.replace(serializers.deserialize(value,
              specifiedType: const FullType(Featured)) as Featured);
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Category)])) as BuiltList);
          break;
        case 'movies':
          result.movies.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(PostList)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$HomePageMovies extends HomePageMovies {
  @override
  final Featured featured;
  @override
  final BuiltList<Category> categories;
  @override
  final BuiltMap<String, PostList> movies;

  factory _$HomePageMovies([void Function(HomePageMoviesBuilder) updates]) =>
      (new HomePageMoviesBuilder()..update(updates)).build();

  _$HomePageMovies._({this.featured, this.categories, this.movies})
      : super._() {
    if (featured == null) {
      throw new BuiltValueNullFieldError('HomePageMovies', 'featured');
    }
    if (categories == null) {
      throw new BuiltValueNullFieldError('HomePageMovies', 'categories');
    }
    if (movies == null) {
      throw new BuiltValueNullFieldError('HomePageMovies', 'movies');
    }
  }

  @override
  HomePageMovies rebuild(void Function(HomePageMoviesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomePageMoviesBuilder toBuilder() =>
      new HomePageMoviesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomePageMovies &&
        featured == other.featured &&
        categories == other.categories &&
        movies == other.movies;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, featured.hashCode), categories.hashCode), movies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomePageMovies')
          ..add('featured', featured)
          ..add('categories', categories)
          ..add('movies', movies))
        .toString();
  }
}

class HomePageMoviesBuilder
    implements Builder<HomePageMovies, HomePageMoviesBuilder> {
  _$HomePageMovies _$v;

  FeaturedBuilder _featured;
  FeaturedBuilder get featured => _$this._featured ??= new FeaturedBuilder();
  set featured(FeaturedBuilder featured) => _$this._featured = featured;

  ListBuilder<Category> _categories;
  ListBuilder<Category> get categories =>
      _$this._categories ??= new ListBuilder<Category>();
  set categories(ListBuilder<Category> categories) =>
      _$this._categories = categories;

  MapBuilder<String, PostList> _movies;
  MapBuilder<String, PostList> get movies =>
      _$this._movies ??= new MapBuilder<String, PostList>();
  set movies(MapBuilder<String, PostList> movies) => _$this._movies = movies;

  HomePageMoviesBuilder();

  HomePageMoviesBuilder get _$this {
    if (_$v != null) {
      _featured = _$v.featured?.toBuilder();
      _categories = _$v.categories?.toBuilder();
      _movies = _$v.movies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomePageMovies other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomePageMovies;
  }

  @override
  void update(void Function(HomePageMoviesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomePageMovies build() {
    _$HomePageMovies _$result;
    try {
      _$result = _$v ??
          new _$HomePageMovies._(
              featured: featured.build(),
              categories: categories.build(),
              movies: movies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'featured';
        featured.build();
        _$failedField = 'categories';
        categories.build();
        _$failedField = 'movies';
        movies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomePageMovies', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
