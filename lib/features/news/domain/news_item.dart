import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_item.freezed.dart';
part 'news_item.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum NewsCategory { campaign, newProduct, info }

@freezed
class NewsItem with _$NewsItem {
  const factory NewsItem({
    required String id,
    required String title,
    required String body,
    required NewsCategory category,
    required DateTime publishedAt,
  }) = _NewsItem;

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);
}
