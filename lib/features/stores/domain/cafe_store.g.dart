// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessHoursImpl _$$BusinessHoursImplFromJson(Map<String, dynamic> json) =>
    _$BusinessHoursImpl(
      open: json['open'] as String,
      close: json['close'] as String,
    );

Map<String, dynamic> _$$BusinessHoursImplToJson(_$BusinessHoursImpl instance) =>
    <String, dynamic>{
      'open': instance.open,
      'close': instance.close,
    };

_$CafeStoreImpl _$$CafeStoreImplFromJson(Map<String, dynamic> json) =>
    _$CafeStoreImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      area: json['area'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      weekdayHours:
          BusinessHours.fromJson(json['weekdayHours'] as Map<String, dynamic>),
      weekendHours:
          BusinessHours.fromJson(json['weekendHours'] as Map<String, dynamic>),
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StoreFeatureEnumMap, e))
              .toList() ??
          const <StoreFeature>[],
      mobileOrder: json['mobileOrder'] as bool? ?? true,
      congestion: $enumDecodeNullable(_$CongestionEnumMap, json['congestion']),
    );

Map<String, dynamic> _$$CafeStoreImplToJson(_$CafeStoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'area': instance.area,
      'address': instance.address,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'weekdayHours': instance.weekdayHours.toJson(),
      'weekendHours': instance.weekendHours.toJson(),
      'features':
          instance.features.map((e) => _$StoreFeatureEnumMap[e]!).toList(),
      'mobileOrder': instance.mobileOrder,
      'congestion': _$CongestionEnumMap[instance.congestion],
    };

const _$StoreFeatureEnumMap = {
  StoreFeature.wifi: 'wifi',
  StoreFeature.power: 'power',
  StoreFeature.terrace: 'terrace',
  StoreFeature.roastery: 'roastery',
};

const _$CongestionEnumMap = {
  Congestion.low: 'low',
  Congestion.moderate: 'moderate',
  Congestion.high: 'high',
};
