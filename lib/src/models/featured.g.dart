// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Featured> _$featuredSerializer = new _$FeaturedSerializer();
Serializer<FeaturedItem> _$featuredItemSerializer =
    new _$FeaturedItemSerializer();

class _$FeaturedSerializer implements StructuredSerializer<Featured> {
  @override
  final Iterable<Type> types = const [Featured, _$Featured];
  @override
  final String wireName = 'Featured';

  @override
  Iterable serialize(Serializers serializers, Featured object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'featured',
      serializers.serialize(object.featured,
          specifiedType:
              const FullType(BuiltList, const [const FullType(FeaturedItem)])),
    ];

    return result;
  }

  @override
  Featured deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeaturedBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'featured':
          result.featured.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(FeaturedItem)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$FeaturedItemSerializer implements StructuredSerializer<FeaturedItem> {
  @override
  final Iterable<Type> types = const [FeaturedItem, _$FeaturedItem];
  @override
  final String wireName = 'FeaturedItem';

  @override
  Iterable serialize(Serializers serializers, FeaturedItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
    ];
    if (object.large != null) {
      result
        ..add('large')
        ..add(serializers.serialize(object.large,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  FeaturedItem deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeaturedItemBuilder();

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
        case 'large':
          result.large = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Featured extends Featured {
  @override
  final BuiltList<FeaturedItem> featured;

  factory _$Featured([void Function(FeaturedBuilder) updates]) =>
      (new FeaturedBuilder()..update(updates)).build();

  _$Featured._({this.featured}) : super._() {
    if (featured == null) {
      throw new BuiltValueNullFieldError('Featured', 'featured');
    }
  }

  @override
  Featured rebuild(void Function(FeaturedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeaturedBuilder toBuilder() => new FeaturedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Featured && featured == other.featured;
  }

  @override
  int get hashCode {
    return $jf($jc(0, featured.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Featured')..add('featured', featured))
        .toString();
  }
}

class FeaturedBuilder implements Builder<Featured, FeaturedBuilder> {
  _$Featured _$v;

  ListBuilder<FeaturedItem> _featured;
  ListBuilder<FeaturedItem> get featured =>
      _$this._featured ??= new ListBuilder<FeaturedItem>();
  set featured(ListBuilder<FeaturedItem> featured) =>
      _$this._featured = featured;

  FeaturedBuilder();

  FeaturedBuilder get _$this {
    if (_$v != null) {
      _featured = _$v.featured?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Featured other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Featured;
  }

  @override
  void update(void Function(FeaturedBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Featured build() {
    _$Featured _$result;
    try {
      _$result = _$v ?? new _$Featured._(featured: featured.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'featured';
        featured.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Featured', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$FeaturedItem extends FeaturedItem {
  @override
  final String id;
  @override
  final String title;
  @override
  final String large;
  @override
  final String type;

  factory _$FeaturedItem([void Function(FeaturedItemBuilder) updates]) =>
      (new FeaturedItemBuilder()..update(updates)).build();

  _$FeaturedItem._({this.id, this.title, this.large, this.type}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('FeaturedItem', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('FeaturedItem', 'title');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('FeaturedItem', 'type');
    }
  }

  @override
  FeaturedItem rebuild(void Function(FeaturedItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeaturedItemBuilder toBuilder() => new FeaturedItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeaturedItem &&
        id == other.id &&
        title == other.title &&
        large == other.large &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), title.hashCode), large.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeaturedItem')
          ..add('id', id)
          ..add('title', title)
          ..add('large', large)
          ..add('type', type))
        .toString();
  }
}

class FeaturedItemBuilder
    implements Builder<FeaturedItem, FeaturedItemBuilder> {
  _$FeaturedItem _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _large;
  String get large => _$this._large;
  set large(String large) => _$this._large = large;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  FeaturedItemBuilder();

  FeaturedItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _large = _$v.large;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeaturedItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FeaturedItem;
  }

  @override
  void update(void Function(FeaturedItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeaturedItem build() {
    final _$result = _$v ??
        new _$FeaturedItem._(id: id, title: title, large: large, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
