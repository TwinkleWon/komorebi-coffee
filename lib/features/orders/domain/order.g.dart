// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderLineImpl _$$OrderLineImplFromJson(Map<String, dynamic> json) =>
    _$OrderLineImpl(
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      options: json['options'] as String?,
      unitPrice: (json['unitPrice'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderLineImplToJson(_$OrderLineImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'name': instance.name,
      'options': instance.options,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
    };

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String,
      number: (json['number'] as num).toInt(),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      lines: (json['lines'] as List<dynamic>)
          .map((e) => OrderLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toInt(),
      pointsUsed: (json['pointsUsed'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num).toInt(),
      pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      pickupAt: DateTime.parse(json['pickupAt'] as String),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'lines': instance.lines.map((e) => e.toJson()).toList(),
      'subtotal': instance.subtotal,
      'pointsUsed': instance.pointsUsed,
      'total': instance.total,
      'pointsEarned': instance.pointsEarned,
      'createdAt': instance.createdAt.toIso8601String(),
      'pickupAt': instance.pickupAt.toIso8601String(),
    };
