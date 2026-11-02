// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsItemImpl _$$NewsItemImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      category: $enumDecode(_$NewsCategoryEnumMap, json['category']),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$$NewsItemImplToJson(_$NewsItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'category': _$NewsCategoryEnumMap[instance.category]!,
      'publishedAt': instance.publishedAt.toIso8601String(),
    };

const _$NewsCategoryEnumMap = {
  NewsCategory.campaign: 'campaign',
  NewsCategory.newProduct: 'new_product',
  NewsCategory.info: 'info',
};
