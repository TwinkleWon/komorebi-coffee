// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderLine _$OrderLineFromJson(Map<String, dynamic> json) {
  return _OrderLine.fromJson(json);
}

/// @nodoc
mixin _$OrderLine {
  String get itemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get options => throw _privateConstructorUsedError;
  int get unitPrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this OrderLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderLineCopyWith<OrderLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderLineCopyWith<$Res> {
  factory $OrderLineCopyWith(OrderLine value, $Res Function(OrderLine) then) =
      _$OrderLineCopyWithImpl<$Res, OrderLine>;
  @useResult
  $Res call(
      {String itemId,
      String name,
      String? options,
      int unitPrice,
      int quantity});
}

/// @nodoc
class _$OrderLineCopyWithImpl<$Res, $Val extends OrderLine>
    implements $OrderLineCopyWith<$Res> {
  _$OrderLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? options = freezed,
    Object? unitPrice = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderLineImplCopyWith<$Res>
    implements $OrderLineCopyWith<$Res> {
  factory _$$OrderLineImplCopyWith(
          _$OrderLineImpl value, $Res Function(_$OrderLineImpl) then) =
      __$$OrderLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String itemId,
      String name,
      String? options,
      int unitPrice,
      int quantity});
}

/// @nodoc
class __$$OrderLineImplCopyWithImpl<$Res>
    extends _$OrderLineCopyWithImpl<$Res, _$OrderLineImpl>
    implements _$$OrderLineImplCopyWith<$Res> {
  __$$OrderLineImplCopyWithImpl(
      _$OrderLineImpl _value, $Res Function(_$OrderLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? options = freezed,
    Object? unitPrice = null,
    Object? quantity = null,
  }) {
    return _then(_$OrderLineImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderLineImpl extends _OrderLine {
  const _$OrderLineImpl(
      {required this.itemId,
      required this.name,
      this.options,
      required this.unitPrice,
      required this.quantity})
      : super._();

  factory _$OrderLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderLineImplFromJson(json);

  @override
  final String itemId;
  @override
  final String name;
  @override
  final String? options;
  @override
  final int unitPrice;
  @override
  final int quantity;

  @override
  String toString() {
    return 'OrderLine(itemId: $itemId, name: $name, options: $options, unitPrice: $unitPrice, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLineImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.options, options) || other.options == options) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, itemId, name, options, unitPrice, quantity);

  /// Create a copy of OrderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLineImplCopyWith<_$OrderLineImpl> get copyWith =>
      __$$OrderLineImplCopyWithImpl<_$OrderLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderLineImplToJson(
      this,
    );
  }
}

abstract class _OrderLine extends OrderLine {
  const factory _OrderLine(
      {required final String itemId,
      required final String name,
      final String? options,
      required final int unitPrice,
      required final int quantity}) = _$OrderLineImpl;
  const _OrderLine._() : super._();

  factory _OrderLine.fromJson(Map<String, dynamic> json) =
      _$OrderLineImpl.fromJson;

  @override
  String get itemId;
  @override
  String get name;
  @override
  String? get options;
  @override
  int get unitPrice;
  @override
  int get quantity;

  /// Create a copy of OrderLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLineImplCopyWith<_$OrderLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;

  /// Short number called out at the pickup counter.
  int get number => throw _privateConstructorUsedError;
  String get storeId => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  List<OrderLine> get lines => throw _privateConstructorUsedError;
  int get subtotal => throw _privateConstructorUsedError;
  int get pointsUsed => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get pickupAt => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String id,
      int number,
      String storeId,
      String storeName,
      List<OrderLine> lines,
      int subtotal,
      int pointsUsed,
      int total,
      int pointsEarned,
      DateTime createdAt,
      DateTime pickupAt});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? lines = null,
    Object? subtotal = null,
    Object? pointsUsed = null,
    Object? total = null,
    Object? pointsEarned = null,
    Object? createdAt = null,
    Object? pickupAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      lines: null == lines
          ? _value.lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<OrderLine>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      pointsUsed: null == pointsUsed
          ? _value.pointsUsed
          : pointsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pickupAt: null == pickupAt
          ? _value.pickupAt
          : pickupAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int number,
      String storeId,
      String storeName,
      List<OrderLine> lines,
      int subtotal,
      int pointsUsed,
      int total,
      int pointsEarned,
      DateTime createdAt,
      DateTime pickupAt});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? lines = null,
    Object? subtotal = null,
    Object? pointsUsed = null,
    Object? total = null,
    Object? pointsEarned = null,
    Object? createdAt = null,
    Object? pickupAt = null,
  }) {
    return _then(_$OrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      lines: null == lines
          ? _value._lines
          : lines // ignore: cast_nullable_to_non_nullable
              as List<OrderLine>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as int,
      pointsUsed: null == pointsUsed
          ? _value.pointsUsed
          : pointsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pickupAt: null == pickupAt
          ? _value.pickupAt
          : pickupAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl extends _Order {
  const _$OrderImpl(
      {required this.id,
      required this.number,
      required this.storeId,
      required this.storeName,
      required final List<OrderLine> lines,
      required this.subtotal,
      this.pointsUsed = 0,
      required this.total,
      this.pointsEarned = 0,
      required this.createdAt,
      required this.pickupAt})
      : _lines = lines,
        super._();

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String id;

  /// Short number called out at the pickup counter.
  @override
  final int number;
  @override
  final String storeId;
  @override
  final String storeName;
  final List<OrderLine> _lines;
  @override
  List<OrderLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  final int subtotal;
  @override
  @JsonKey()
  final int pointsUsed;
  @override
  final int total;
  @override
  @JsonKey()
  final int pointsEarned;
  @override
  final DateTime createdAt;
  @override
  final DateTime pickupAt;

  @override
  String toString() {
    return 'Order(id: $id, number: $number, storeId: $storeId, storeName: $storeName, lines: $lines, subtotal: $subtotal, pointsUsed: $pointsUsed, total: $total, pointsEarned: $pointsEarned, createdAt: $createdAt, pickupAt: $pickupAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.pointsUsed, pointsUsed) ||
                other.pointsUsed == pointsUsed) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.pickupAt, pickupAt) ||
                other.pickupAt == pickupAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      number,
      storeId,
      storeName,
      const DeepCollectionEquality().hash(_lines),
      subtotal,
      pointsUsed,
      total,
      pointsEarned,
      createdAt,
      pickupAt);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order extends Order {
  const factory _Order(
      {required final String id,
      required final int number,
      required final String storeId,
      required final String storeName,
      required final List<OrderLine> lines,
      required final int subtotal,
      final int pointsUsed,
      required final int total,
      final int pointsEarned,
      required final DateTime createdAt,
      required final DateTime pickupAt}) = _$OrderImpl;
  const _Order._() : super._();

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get id;

  /// Short number called out at the pickup counter.
  @override
  int get number;
  @override
  String get storeId;
  @override
  String get storeName;
  @override
  List<OrderLine> get lines;
  @override
  int get subtotal;
  @override
  int get pointsUsed;
  @override
  int get total;
  @override
  int get pointsEarned;
  @override
  DateTime get createdAt;
  @override
  DateTime get pickupAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
