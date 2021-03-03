// GENERATED CODE - DO NOT MODIFY BY HAND

part of item;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Item extends Item {
  @override
  final DateTime ctime;
  @override
  final String description;

  factory _$Item([void Function(ItemBuilder)? updates]) =>
      (new ItemBuilder()..update(updates)).build();

  _$Item._({required this.ctime, required this.description}) : super._() {
    BuiltValueNullFieldError.checkNotNull(ctime, 'Item', 'ctime');
    BuiltValueNullFieldError.checkNotNull(description, 'Item', 'description');
  }

  @override
  Item rebuild(void Function(ItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemBuilder toBuilder() => new ItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item &&
        ctime == other.ctime &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, ctime.hashCode), description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Item')
          ..add('ctime', ctime)
          ..add('description', description))
        .toString();
  }
}

class ItemBuilder implements Builder<Item, ItemBuilder> {
  _$Item? _$v;

  DateTime? _ctime;
  DateTime? get ctime => _$this._ctime;
  set ctime(DateTime? ctime) => _$this._ctime = ctime;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ItemBuilder();

  ItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ctime = $v.ctime;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Item other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Item;
  }

  @override
  void update(void Function(ItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Item build() {
    final _$result = _$v ??
        new _$Item._(
            ctime:
                BuiltValueNullFieldError.checkNotNull(ctime, 'Item', 'ctime'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, 'Item', 'description'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
