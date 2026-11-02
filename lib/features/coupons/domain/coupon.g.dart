// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CouponImpl _$$CouponImplFromJson(Map<String, dynamic> json) => _$CouponImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      kind: $enumDecode(_$CouponKindEnumMap, json['kind']),
      value: (json['value'] as num?)?.toInt() ?? 0,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      usedAt: json['usedAt'] == null
          ? null
          : DateTime.parse(json['usedAt'] as String),
      redemptionCode: json['redemptionCode'] as String?,
    );

Map<String, dynamic> _$$CouponImplToJson(_$CouponImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'kind': _$CouponKindEnumMap[instance.kind]!,
      'value': instance.value,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'conditions': instance.conditions,
      'usedAt': instance.usedAt?.toIso8601String(),
      'redemptionCode': instance.redemptionCode,
    };

const _$CouponKindEnumMap = {
  CouponKind.percentOff: 'percent_off',
  CouponKind.yenOff: 'yen_off',
  CouponKind.freeItem: 'free_item',
  CouponKind.sizeUp: 'size_up',
};
