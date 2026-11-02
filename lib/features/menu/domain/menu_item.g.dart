// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemImpl _$$MenuItemImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['nameEn'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$MenuCategoryEnumMap, json['category']),
      price: (json['price'] as num).toInt(),
      customizable: json['customizable'] as bool? ?? false,
      available: json['available'] as bool? ?? true,
      isNew: json['isNew'] as bool? ?? false,
      tone: json['tone'] as String? ?? 'B8794B',
      kcal: (json['kcal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MenuItemImplToJson(_$MenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'description': instance.description,
      'category': _$MenuCategoryEnumMap[instance.category]!,
      'price': instance.price,
      'customizable': instance.customizable,
      'available': instance.available,
      'isNew': instance.isNew,
      'tone': instance.tone,
      'kcal': instance.kcal,
    };

const _$MenuCategoryEnumMap = {
  MenuCategory.coffee: 'coffee',
  MenuCategory.tea: 'tea',
  MenuCategory.seasonal: 'seasonal',
  MenuCategory.food: 'food',
};
