// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      memberNumber: json['memberNumber'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      provider: json['provider'] as String? ?? 'line',
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'memberNumber': instance.memberNumber,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'provider': instance.provider,
    };
