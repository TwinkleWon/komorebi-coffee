// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return _MenuItem.fromJson(json);
}

/// @nodoc
mixin _$MenuItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MenuCategory get category => throw _privateConstructorUsedError;

  /// Base price (tax included) for the smallest size.
  int get price => throw _privateConstructorUsedError;

  /// Drinks that offer size and hot / iced choices.
  bool get customizable => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;

  /// Hex color used for the illustrated thumbnail.
  String get tone => throw _privateConstructorUsedError;
  int? get kcal => throw _privateConstructorUsedError;

  /// Serializes this MenuItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemCopyWith<MenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemCopyWith<$Res> {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) then) =
      _$MenuItemCopyWithImpl<$Res, MenuItem>;
  @useResult
  $Res call(
      {String id,
      String name,
      String nameEn,
      String description,
      MenuCategory category,
      int price,
      bool customizable,
      bool available,
      bool isNew,
      String tone,
      int? kcal});
}

/// @nodoc
class _$MenuItemCopyWithImpl<$Res, $Val extends MenuItem>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = null,
    Object? description = null,
    Object? category = null,
    Object? price = null,
    Object? customizable = null,
    Object? available = null,
    Object? isNew = null,
    Object? tone = null,
    Object? kcal = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MenuCategory,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      customizable: null == customizable
          ? _value.customizable
          : customizable // ignore: cast_nullable_to_non_nullable
              as bool,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      kcal: freezed == kcal
          ? _value.kcal
          : kcal // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$MenuItemImplCopyWith(
          _$MenuItemImpl value, $Res Function(_$MenuItemImpl) then) =
      __$$MenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String nameEn,
      String description,
      MenuCategory category,
      int price,
      bool customizable,
      bool available,
      bool isNew,
      String tone,
      int? kcal});
}

/// @nodoc
class __$$MenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$MenuItemImpl>
    implements _$$MenuItemImplCopyWith<$Res> {
  __$$MenuItemImplCopyWithImpl(
      _$MenuItemImpl _value, $Res Function(_$MenuItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = null,
    Object? description = null,
    Object? category = null,
    Object? price = null,
    Object? customizable = null,
    Object? available = null,
    Object? isNew = null,
    Object? tone = null,
    Object? kcal = freezed,
  }) {
    return _then(_$MenuItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MenuCategory,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      customizable: null == customizable
          ? _value.customizable
          : customizable // ignore: cast_nullable_to_non_nullable
              as bool,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      kcal: freezed == kcal
          ? _value.kcal
          : kcal // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemImpl implements _MenuItem {
  const _$MenuItemImpl(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.description,
      required this.category,
      required this.price,
      this.customizable = false,
      this.available = true,
      this.isNew = false,
      this.tone = 'B8794B',
      this.kcal});

  factory _$MenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String nameEn;
  @override
  final String description;
  @override
  final MenuCategory category;

  /// Base price (tax included) for the smallest size.
  @override
  final int price;

  /// Drinks that offer size and hot / iced choices.
  @override
  @JsonKey()
  final bool customizable;
  @override
  @JsonKey()
  final bool available;
  @override
  @JsonKey()
  final bool isNew;

  /// Hex color used for the illustrated thumbnail.
  @override
  @JsonKey()
  final String tone;
  @override
  final int? kcal;

  @override
  String toString() {
    return 'MenuItem(id: $id, name: $name, nameEn: $nameEn, description: $description, category: $category, price: $price, customizable: $customizable, available: $available, isNew: $isNew, tone: $tone, kcal: $kcal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.customizable, customizable) ||
                other.customizable == customizable) &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.kcal, kcal) || other.kcal == kcal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameEn, description,
      category, price, customizable, available, isNew, tone, kcal);

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      __$$MenuItemImplCopyWithImpl<_$MenuItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemImplToJson(
      this,
    );
  }
}

abstract class _MenuItem implements MenuItem {
  const factory _MenuItem(
      {required final String id,
      required final String name,
      required final String nameEn,
      required final String description,
      required final MenuCategory category,
      required final int price,
      final bool customizable,
      final bool available,
      final bool isNew,
      final String tone,
      final int? kcal}) = _$MenuItemImpl;

  factory _MenuItem.fromJson(Map<String, dynamic> json) =
      _$MenuItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get nameEn;
  @override
  String get description;
  @override
  MenuCategory get category;

  /// Base price (tax included) for the smallest size.
  @override
  int get price;

  /// Drinks that offer size and hot / iced choices.
  @override
  bool get customizable;
  @override
  bool get available;
  @override
  bool get isNew;

  /// Hex color used for the illustrated thumbnail.
  @override
  String get tone;
  @override
  int? get kcal;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
