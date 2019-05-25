// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Category> _$categorySerializer = new _$CategorySerializer();

class _$CategorySerializer implements StructuredSerializer<Category> {
  @override
  final Iterable<Type> types = const [Category, _$Category];
  @override
  final String wireName = 'Category';

  @override
  Iterable serialize(Serializers serializers, Category object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    if (object.badquality != null) {
      result
        ..add('badquality')
        ..add(serializers.serialize(object.badquality,
            specifiedType: const FullType(String)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.vorder != null) {
      result
        ..add('vorder')
        ..add(serializers.serialize(object.vorder,
            specifiedType: const FullType(String)));
    }
    if (object.imdb != null) {
      result
        ..add('imdb')
        ..add(serializers.serialize(object.imdb,
            specifiedType: const FullType(String)));
    }
    if (object.elcinema != null) {
      result
        ..add('elcinema')
        ..add(serializers.serialize(object.elcinema,
            specifiedType: const FullType(String)));
    }
    if (object.parent != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(object.parent,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Category deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategoryBuilder();

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
        case 'badquality':
          result.badquality = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vorder':
          result.vorder = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imdb':
          result.imdb = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'elcinema':
          result.elcinema = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Category extends Category {
  @override
  final String id;
  @override
  final String title;
  @override
  final String badquality;
  @override
  final String type;
  @override
  final String vorder;
  @override
  final String imdb;
  @override
  final String elcinema;
  @override
  final String parent;

  factory _$Category([void Function(CategoryBuilder) updates]) =>
      (new CategoryBuilder()..update(updates)).build();

  _$Category._(
      {this.id,
      this.title,
      this.badquality,
      this.type,
      this.vorder,
      this.imdb,
      this.elcinema,
      this.parent})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Category', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Category', 'title');
    }
  }

  @override
  Category rebuild(void Function(CategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryBuilder toBuilder() => new CategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Category &&
        id == other.id &&
        title == other.title &&
        badquality == other.badquality &&
        type == other.type &&
        vorder == other.vorder &&
        imdb == other.imdb &&
        elcinema == other.elcinema &&
        parent == other.parent;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), title.hashCode),
                            badquality.hashCode),
                        type.hashCode),
                    vorder.hashCode),
                imdb.hashCode),
            elcinema.hashCode),
        parent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Category')
          ..add('id', id)
          ..add('title', title)
          ..add('badquality', badquality)
          ..add('type', type)
          ..add('vorder', vorder)
          ..add('imdb', imdb)
          ..add('elcinema', elcinema)
          ..add('parent', parent))
        .toString();
  }
}

class CategoryBuilder implements Builder<Category, CategoryBuilder> {
  _$Category _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _badquality;
  String get badquality => _$this._badquality;
  set badquality(String badquality) => _$this._badquality = badquality;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _vorder;
  String get vorder => _$this._vorder;
  set vorder(String vorder) => _$this._vorder = vorder;

  String _imdb;
  String get imdb => _$this._imdb;
  set imdb(String imdb) => _$this._imdb = imdb;

  String _elcinema;
  String get elcinema => _$this._elcinema;
  set elcinema(String elcinema) => _$this._elcinema = elcinema;

  String _parent;
  String get parent => _$this._parent;
  set parent(String parent) => _$this._parent = parent;

  CategoryBuilder();

  CategoryBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _badquality = _$v.badquality;
      _type = _$v.type;
      _vorder = _$v.vorder;
      _imdb = _$v.imdb;
      _elcinema = _$v.elcinema;
      _parent = _$v.parent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Category other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Category;
  }

  @override
  void update(void Function(CategoryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Category build() {
    final _$result = _$v ??
        new _$Category._(
            id: id,
            title: title,
            badquality: badquality,
            type: type,
            vorder: vorder,
            imdb: imdb,
            elcinema: elcinema,
            parent: parent);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
