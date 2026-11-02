// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CartLine {
  MenuItem get item => throw _privateConstructorUsedError;
  DrinkSize? get size => throw _privateConstructorUsedError;
  Temperature? get temperature => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartLineCopyWith<CartLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartLineCopyWith<$Res> {
  factory $CartLineCopyWith(CartLine value, $Res Function(CartLine) then) =
      _$CartLineCopyWithImpl<$Res, CartLine>;
  @useResult
  $Res call(
      {MenuItem item, DrinkSize? size, Temperature? temperature, int quantity});

  $MenuItemCopyWith<$Res> get item;
}

/// @nodoc
class _$CartLineCopyWithImpl<$Res, $Val extends CartLine>
    implements $CartLineCopyWith<$Res> {
  _$CartLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? size = freezed,
    Object? temperature = freezed,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MenuItem,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as DrinkSize?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as Temperature?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MenuItemCopyWith<$Res> get item {
    return $MenuItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartLineImplCopyWith<$Res>
    implements $CartLineCopyWith<$Res> {
  factory _$$CartLineImplCopyWith(
          _$CartLineImpl value, $Res Function(_$CartLineImpl) then) =
      __$$CartLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MenuItem item, DrinkSize? size, Temperature? temperature, int quantity});

  @override
  $MenuItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$CartLineImplCopyWithImpl<$Res>
    extends _$CartLineCopyWithImpl<$Res, _$CartLineImpl>
    implements _$$CartLineImplCopyWith<$Res> {
  __$$CartLineImplCopyWithImpl(
      _$CartLineImpl _value, $Res Function(_$CartLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? size = freezed,
    Object? temperature = freezed,
    Object? quantity = null,
  }) {
    return _then(_$CartLineImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MenuItem,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as DrinkSize?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as Temperature?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CartLineImpl extends _CartLine {
  const _$CartLineImpl(
      {required this.item, this.size, this.temperature, this.quantity = 1})
      : super._();

  @override
  final MenuItem item;
  @override
  final DrinkSize? size;
  @override
  final Temperature? temperature;
  @override
  @JsonKey()
  final int quantity;

  @override
  String toString() {
    return 'CartLine(item: $item, size: $size, temperature: $temperature, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartLineImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, item, size, temperature, quantity);

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartLineImplCopyWith<_$CartLineImpl> get copyWith =>
      __$$CartLineImplCopyWithImpl<_$CartLineImpl>(this, _$identity);
}

abstract class _CartLine extends CartLine {
  const factory _CartLine(
      {required final MenuItem item,
      final DrinkSize? size,
      final Temperature? temperature,
      final int quantity}) = _$CartLineImpl;
  const _CartLine._() : super._();

  @override
  MenuItem get item;
  @override
  DrinkSize? get size;
  @override
  Temperature? get temperature;
  @override
  int get quantity;

  /// Create a copy of CartLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartLineImplCopyWith<_$CartLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Cart {
  CafeStore? get store => throw _privateConstructorUsedError;
  List<CartLine> get lines => throw _privateConstructorUsedError;
  PickupSlot get pickupSlot => throw _privateConstructorUsedError;
  bool get usePoints => throw _privateConstructorUsedError;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res, Cart>;
  @useResult
  $Res call(
      {CafeStore? store,
      List<CartLine> lines,
      PickupSlot pickupSlot,
      bool usePoints});

  $CafeStoreCopyWith<$Res>? get store;
}

/// @nodoc
class _$CartCopyWithImpl<$Res, $Val extends Cart>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? store = freezed,
    Object? lines = null,
    Object? pickupSlot = null,
    Object? usePoints = null,
  }) {
    return _then(_value.copyWith(
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as CafeStore?,
      lines: null == lines
          ? _value.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<CartLine>,
      pickupSlot: null == pickupSlot
          ? _value.pickupSlot
          : pickupSlot // ignore: cast_nullable_to_non_nullable
              as PickupSlot,
      usePoints: null == usePoints
          ? _value.usePoints
          : usePoints // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CafeStoreCopyWith<$Res>? get store {
    if (_value.store == null) {
      return null;
    }

    return $CafeStoreCopyWith<$Res>(_value.store!, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartImplCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$CartImplCopyWith(
          _$CartImpl value, $Res Function(_$CartImpl) then) =
      __$$CartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CafeStore? store,
      List<CartLine> lines,
      PickupSlot pickupSlot,
      bool usePoints});

  @override
  $CafeStoreCopyWith<$Res>? get store;
}

/// @nodoc
class __$$CartImplCopyWithImpl<$Res>
    extends _$CartCopyWithImpl<$Res, _$CartImpl>
    implements _$$CartImplCopyWith<$Res> {
  __$$CartImplCopyWithImpl(_$CartImpl _value, $Res Function(_$CartImpl) _then)
      : super(_value, _then);

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? store = freezed,
    Object? lines = null,
    Object? pickupSlot = null,
    Object? usePoints = null,
  }) {
    return _then(_$CartImpl(
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as CafeStore?,
      lines: null == lines
          ? _value._lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<CartLine>,
      pickupSlot: null == pickupSlot
          ? _value.pickupSlot
          : pickupSlot // ignore: cast_nullable_to_non_nullable
              as PickupSlot,
      usePoints: null == usePoints
          ? _value.usePoints
          : usePoints // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CartImpl extends _Cart {
  const _$CartImpl(
      {this.store,
      final List<CartLine> lines = const <CartLine>[],
      this.pickupSlot = PickupSlot.asap,
      this.usePoints = false})
      : _lines = lines,
        super._();

  @override
  final CafeStore? store;
  final List<CartLine> _lines;
  @override
  @JsonKey()
  List<CartLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  @JsonKey()
  final PickupSlot pickupSlot;
  @override
  @JsonKey()
  final bool usePoints;

  @override
  String toString() {
    return 'Cart(store: $store, lines: $lines, pickupSlot: $pickupSlot, usePoints: $usePoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartImpl &&
            (identical(other.store, store) || other.store == store) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.pickupSlot, pickupSlot) ||
                other.pickupSlot == pickupSlot) &&
            (identical(other.usePoints, usePoints) ||
                other.usePoints == usePoints));
  }

  @override
  int get hashCode => Object.hash(runtimeType, store,
      const DeepCollectionEquality().hash(_lines), pickupSlot, usePoints);

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      __$$CartImplCopyWithImpl<_$CartImpl>(this, _$identity);
}

abstract class _Cart extends Cart {
  const factory _Cart(
      {final CafeStore? store,
      final List<CartLine> lines,
      final PickupSlot pickupSlot,
      final bool usePoints}) = _$CartImpl;
  const _Cart._() : super._();

  @override
  CafeStore? get store;
  @override
  List<CartLine> get lines;
  @override
  PickupSlot get pickupSlot;
  @override
  bool get usePoints;

  /// Create a copy of Cart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
