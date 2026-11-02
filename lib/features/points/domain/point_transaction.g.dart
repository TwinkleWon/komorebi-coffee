// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointTransactionImpl _$$PointTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$PointTransactionImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      reason: $enumDecode(_$PointReasonEnumMap, json['reason']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      orderNumber: (json['orderNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PointTransactionImplToJson(
        _$PointTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'reason': _$PointReasonEnumMap[instance.reason]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'orderNumber': instance.orderNumber,
    };

const _$PointReasonEnumMap = {
  PointReason.welcome: 'welcome',
  PointReason.orderEarn: 'order_earn',
  PointReason.orderSpend: 'order_spend',
};

_$PointSummaryImpl _$$PointSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PointSummaryImpl(
      balance: (json['balance'] as num).toInt(),
      lifetimeEarned: (json['lifetimeEarned'] as num).toInt(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => PointTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PointSummaryImplToJson(_$PointSummaryImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'lifetimeEarned': instance.lifetimeEarned,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };
