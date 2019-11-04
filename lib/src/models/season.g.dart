// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Season> _$seasonSerializer = new _$SeasonSerializer();
Serializer<Episode> _$episodeSerializer = new _$EpisodeSerializer();

class _$SeasonSerializer implements StructuredSerializer<Season> {
  @override
  final Iterable<Type> types = const [Season, _$Season];
  @override
  final String wireName = 'Season';

  @override
  Iterable serialize(Serializers serializers, Season object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'episode',
      serializers.serialize(object.episode,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Episode)])),
    ];
    if (object.s3 != null) {
      result
        ..add('s3')
        ..add(serializers.serialize(object.s3,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Season deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SeasonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'episode':
          result.episode.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Episode)])) as BuiltList);
          break;
        case 's3':
          result.s3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$EpisodeSerializer implements StructuredSerializer<Episode> {
  @override
  final Iterable<Type> types = const [Episode, _$Episode];
  @override
  final String wireName = 'Episode';

  @override
  Iterable serialize(Serializers serializers, Episode object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.subtitle != null) {
      result
        ..add('subtitle')
        ..add(serializers.serialize(object.subtitle,
            specifiedType: const FullType(String)));
    }
    if (object.url360 != null) {
      result
        ..add('url360')
        ..add(serializers.serialize(object.url360,
            specifiedType: const FullType(String)));
    }
    if (object.url720 != null) {
      result
        ..add('url720')
        ..add(serializers.serialize(object.url720,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Episode deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EpisodeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subtitle':
          result.subtitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url360':
          result.url360 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url720':
          result.url720 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Season extends Season {
  @override
  final String id;
  @override
  final String title;
  @override
  final BuiltList<Episode> episode;
  @override
  final String s3;

  factory _$Season([void Function(SeasonBuilder) updates]) =>
      (new SeasonBuilder()..update(updates)).build();

  _$Season._({this.id, this.title, this.episode, this.s3}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Season', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Season', 'title');
    }
    if (episode == null) {
      throw new BuiltValueNullFieldError('Season', 'episode');
    }
  }

  @override
  Season rebuild(void Function(SeasonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SeasonBuilder toBuilder() => new SeasonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Season &&
        id == other.id &&
        title == other.title &&
        episode == other.episode &&
        s3 == other.s3;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), title.hashCode), episode.hashCode),
        s3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Season')
          ..add('id', id)
          ..add('title', title)
          ..add('episode', episode)
          ..add('s3', s3))
        .toString();
  }
}

class SeasonBuilder implements Builder<Season, SeasonBuilder> {
  _$Season _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<Episode> _episode;
  ListBuilder<Episode> get episode =>
      _$this._episode ??= new ListBuilder<Episode>();
  set episode(ListBuilder<Episode> episode) => _$this._episode = episode;

  String _s3;
  String get s3 => _$this._s3;
  set s3(String s3) => _$this._s3 = s3;

  SeasonBuilder();

  SeasonBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _episode = _$v.episode?.toBuilder();
      _s3 = _$v.s3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Season other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Season;
  }

  @override
  void update(void Function(SeasonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Season build() {
    _$Season _$result;
    try {
      _$result = _$v ??
          new _$Season._(
              id: id, title: title, episode: episode.build(), s3: s3);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'episode';
        episode.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Season', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Episode extends Episode {
  @override
  final String title;
  @override
  final String url;
  @override
  final String id;
  @override
  final String subtitle;
  @override
  final String url360;
  @override
  final String url720;

  factory _$Episode([void Function(EpisodeBuilder) updates]) =>
      (new EpisodeBuilder()..update(updates)).build();

  _$Episode._(
      {this.title, this.url, this.id, this.subtitle, this.url360, this.url720})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('Episode', 'title');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('Episode', 'url');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Episode', 'id');
    }
  }

  @override
  Episode rebuild(void Function(EpisodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EpisodeBuilder toBuilder() => new EpisodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Episode &&
        title == other.title &&
        url == other.url &&
        id == other.id &&
        subtitle == other.subtitle &&
        url360 == other.url360 &&
        url720 == other.url720;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, title.hashCode), url.hashCode), id.hashCode),
                subtitle.hashCode),
            url360.hashCode),
        url720.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Episode')
          ..add('title', title)
          ..add('url', url)
          ..add('id', id)
          ..add('subtitle', subtitle)
          ..add('url360', url360)
          ..add('url720', url720))
        .toString();
  }
}

class EpisodeBuilder implements Builder<Episode, EpisodeBuilder> {
  _$Episode _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _subtitle;
  String get subtitle => _$this._subtitle;
  set subtitle(String subtitle) => _$this._subtitle = subtitle;

  String _url360;
  String get url360 => _$this._url360;
  set url360(String url360) => _$this._url360 = url360;

  String _url720;
  String get url720 => _$this._url720;
  set url720(String url720) => _$this._url720 = url720;

  EpisodeBuilder();

  EpisodeBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _url = _$v.url;
      _id = _$v.id;
      _subtitle = _$v.subtitle;
      _url360 = _$v.url360;
      _url720 = _$v.url720;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Episode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Episode;
  }

  @override
  void update(void Function(EpisodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Episode build() {
    final _$result = _$v ??
        new _$Episode._(
            title: title,
            url: url,
            id: id,
            subtitle: subtitle,
            url360: url360,
            url720: url720);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
