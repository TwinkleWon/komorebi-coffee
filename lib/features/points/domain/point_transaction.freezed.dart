// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointTransaction _$PointTransactionFromJson(Map<String, dynamic> json) {
  return _PointTransaction.fromJson(json);
}

/// @nodoc
mixin _$PointTransaction {
  String get id => throw _privateConstructorUsedError;

  /// Positive when earned, negative when spent.
  int get amount => throw _privateConstructorUsedError;
  PointReason get reason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get orderNumber => throw _privateConstructorUsedError;

  /// Serializes this PointTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointTransactionCopyWith<PointTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointTransactionCopyWith<$Res> {
  factory $PointTransactionCopyWith(
          PointTransaction value, $Res Function(PointTransaction) then) =
      _$PointTransactionCopyWithImpl<$Res, PointTransaction>;
  @useResult
  $Res call(
      {String id,
      int amount,
      PointReason reason,
      DateTime createdAt,
      int? orderNumber});
}

/// @nodoc
class _$PointTransactionCopyWithImpl<$Res, $Val extends PointTransaction>
    implements $PointTransactionCopyWith<$Res> {
  _$PointTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? reason = null,
    Object? createdAt = null,
    Object? orderNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as PointReason,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointTransactionImplCopyWith<$Res>
    implements $PointTransactionCopyWith<$Res> {
  factory _$$PointTransactionImplCopyWith(_$PointTransactionImpl value,
          $Res Function(_$PointTransactionImpl) then) =
      __$$PointTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int amount,
      PointReason reason,
      DateTime createdAt,
      int? orderNumber});
}

/// @nodoc
class __$$PointTransactionImplCopyWithImpl<$Res>
    extends _$PointTransactionCopyWithImpl<$Res, _$PointTransactionImpl>
    implements _$$PointTransactionImplCopyWith<$Res> {
  __$$PointTransactionImplCopyWithImpl(_$PointTransactionImpl _value,
      $Res Function(_$PointTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? reason = null,
    Object? createdAt = null,
    Object? orderNumber = freezed,
  }) {
    return _then(_$PointTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as PointReason,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointTransactionImpl implements _PointTransaction {
  const _$PointTransactionImpl(
      {required this.id,
      required this.amount,
      required this.reason,
      required this.createdAt,
      this.orderNumber});

  factory _$PointTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointTransactionImplFromJson(json);

  @override
  final String id;

  /// Positive when earned, negative when spent.
  @override
  final int amount;
  @override
  final PointReason reason;
  @override
  final DateTime createdAt;
  @override
  final int? orderNumber;

  @override
  String toString() {
    return 'PointTransaction(id: $id, amount: $amount, reason: $reason, createdAt: $createdAt, orderNumber: $orderNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, reason, createdAt, orderNumber);

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointTransactionImplCopyWith<_$PointTransactionImpl> get copyWith =>
      __$$PointTransactionImplCopyWithImpl<_$PointTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointTransactionImplToJson(
      this,
    );
  }
}

abstract class _PointTransaction implements PointTransaction {
  const factory _PointTransaction(
      {required final String id,
      required final int amount,
      required final PointReason reason,
      required final DateTime createdAt,
      final int? orderNumber}) = _$PointTransactionImpl;

  factory _PointTransaction.fromJson(Map<String, dynamic> json) =
      _$PointTransactionImpl.fromJson;

  @override
  String get id;

  /// Positive when earned, negative when spent.
  @override
  int get amount;
  @override
  PointReason get reason;
  @override
  DateTime get createdAt;
  @override
  int? get orderNumber;

  /// Create a copy of PointTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointTransactionImplCopyWith<_$PointTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointSummary _$PointSummaryFromJson(Map<String, dynamic> json) {
  return _PointSummary.fromJson(json);
}

/// @nodoc
mixin _$PointSummary {
  int get balance => throw _privateConstructorUsedError;
  int get lifetimeEarned => throw _privateConstructorUsedError;
  List<PointTransaction> get transactions => throw _privateConstructorUsedError;

  /// Serializes this PointSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointSummaryCopyWith<PointSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointSummaryCopyWith<$Res> {
  factory $PointSummaryCopyWith(
          PointSummary value, $Res Function(PointSummary) then) =
      _$PointSummaryCopyWithImpl<$Res, PointSummary>;
  @useResult
  $Res call(
      {int balance, int lifetimeEarned, List<PointTransaction> transactions});
}

/// @nodoc
class _$PointSummaryCopyWithImpl<$Res, $Val extends PointSummary>
    implements $PointSummaryCopyWith<$Res> {
  _$PointSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? lifetimeEarned = null,
    Object? transactions = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lifetimeEarned: null == lifetimeEarned
          ? _value.lifetimeEarned
          : lifetimeEarned // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<PointTransaction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointSummaryImplCopyWith<$Res>
    implements $PointSummaryCopyWith<$Res> {
  factory _$$PointSummaryImplCopyWith(
          _$PointSummaryImpl value, $Res Function(_$PointSummaryImpl) then) =
      __$$PointSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int balance, int lifetimeEarned, List<PointTransaction> transactions});
}

/// @nodoc
class __$$PointSummaryImplCopyWithImpl<$Res>
    extends _$PointSummaryCopyWithImpl<$Res, _$PointSummaryImpl>
    implements _$$PointSummaryImplCopyWith<$Res> {
  __$$PointSummaryImplCopyWithImpl(
      _$PointSummaryImpl _value, $Res Function(_$PointSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PointSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? lifetimeEarned = null,
    Object? transactions = null,
  }) {
    return _then(_$PointSummaryImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as int,
      lifetimeEarned: null == lifetimeEarned
          ? _value.lifetimeEarned
          : lifetimeEarned // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<PointTransaction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointSummaryImpl extends _PointSummary {
  const _$PointSummaryImpl(
      {required this.balance,
      required this.lifetimeEarned,
      required final List<PointTransaction> transactions})
      : _transactions = transactions,
        super._();

  factory _$PointSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointSummaryImplFromJson(json);

  @override
  final int balance;
  @override
  final int lifetimeEarned;
  final List<PointTransaction> _transactions;
  @override
  List<PointTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'PointSummary(balance: $balance, lifetimeEarned: $lifetimeEarned, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointSummaryImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lifetimeEarned, lifetimeEarned) ||
                other.lifetimeEarned == lifetimeEarned) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, balance, lifetimeEarned,
      const DeepCollectionEquality().hash(_transactions));

  /// Create a copy of PointSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointSummaryImplCopyWith<_$PointSummaryImpl> get copyWith =>
      __$$PointSummaryImplCopyWithImpl<_$PointSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointSummaryImplToJson(
      this,
    );
  }
}

abstract class _PointSummary extends PointSummary {
  const factory _PointSummary(
      {required final int balance,
      required final int lifetimeEarned,
      required final List<PointTransaction> transactions}) = _$PointSummaryImpl;
  const _PointSummary._() : super._();

  factory _PointSummary.fromJson(Map<String, dynamic> json) =
      _$PointSummaryImpl.fromJson;

  @override
  int get balance;
  @override
  int get lifetimeEarned;
  @override
  List<PointTransaction> get transactions;

  /// Create a copy of PointSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointSummaryImplCopyWith<_$PointSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
