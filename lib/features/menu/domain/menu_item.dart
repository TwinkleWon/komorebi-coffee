import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum MenuCategory { coffee, tea, seasonal, food }

enum DrinkSize {
  s(0),
  m(50),
  l(100);

  const DrinkSize(this.priceDelta);

  final int priceDelta;

  String get label => name.toUpperCase();
}

enum Temperature { hot, iced }

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String name,
    required String nameEn,
    required String description,
    required MenuCategory category,

    /// Base price (tax included) for the smallest size.
    required int price,

    /// Drinks that offer size and hot / iced choices.
    @Default(false) bool customizable,
    @Default(true) bool available,
    @Default(false) bool isNew,

    /// Hex color used for the illustrated thumbnail.
    @Default('B8794B') String tone,
    int? kcal,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}
