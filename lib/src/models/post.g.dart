// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Post> _$postSerializer = new _$PostSerializer();

class _$PostSerializer implements StructuredSerializer<Post> {
  @override
  final Iterable<Type> types = const [Post, _$Post];
  @override
  final String wireName = 'Post';

  @override
  Iterable serialize(Serializers serializers, Post object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'movies',
      serializers.serialize(object.movies,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PostListItem)])),
      'other',
      serializers.serialize(object.other,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PostListItem)])),
    ];

    return result;
  }

  @override
  Post deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'movies':
          result.movies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PostListItem)]))
              as BuiltList);
          break;
        case 'other':
          result.other.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PostListItem)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Post extends Post {
  @override
  final BuiltList<PostListItem> movies;
  @override
  final BuiltList<PostListItem> other;

  factory _$Post([void Function(PostBuilder) updates]) =>
      (new PostBuilder()..update(updates)).build();

  _$Post._({this.movies, this.other}) : super._() {
    if (movies == null) {
      throw new BuiltValueNullFieldError('Post', 'movies');
    }
    if (other == null) {
      throw new BuiltValueNullFieldError('Post', 'other');
    }
  }

  @override
  Post rebuild(void Function(PostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostBuilder toBuilder() => new PostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post && movies == other.movies && other == other.other;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, movies.hashCode), other.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Post')
          ..add('movies', movies)
          ..add('other', other))
        .toString();
  }
}

class PostBuilder implements Builder<Post, PostBuilder> {
  _$Post _$v;

  ListBuilder<PostListItem> _movies;
  ListBuilder<PostListItem> get movies =>
      _$this._movies ??= new ListBuilder<PostListItem>();
  set movies(ListBuilder<PostListItem> movies) => _$this._movies = movies;

  ListBuilder<PostListItem> _other;
  ListBuilder<PostListItem> get other =>
      _$this._other ??= new ListBuilder<PostListItem>();
  set other(ListBuilder<PostListItem> other) => _$this._other = other;

  PostBuilder();

  PostBuilder get _$this {
    if (_$v != null) {
      _movies = _$v.movies?.toBuilder();
      _other = _$v.other?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Post other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Post;
  }

  @override
  void update(void Function(PostBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Post build() {
    _$Post _$result;
    try {
      _$result =
          _$v ?? new _$Post._(movies: movies.build(), other: other.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'movies';
        movies.build();
        _$failedField = 'other';
        other.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Post', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
