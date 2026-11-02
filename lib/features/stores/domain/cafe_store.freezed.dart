// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cafe_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) {
  return _BusinessHours.fromJson(json);
}

/// @nodoc
mixin _$BusinessHours {
  String get open => throw _privateConstructorUsedError;
  String get close => throw _privateConstructorUsedError;

  /// Serializes this BusinessHours to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessHoursCopyWith<BusinessHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursCopyWith<$Res> {
  factory $BusinessHoursCopyWith(
          BusinessHours value, $Res Function(BusinessHours) then) =
      _$BusinessHoursCopyWithImpl<$Res, BusinessHours>;
  @useResult
  $Res call({String open, String close});
}

/// @nodoc
class _$BusinessHoursCopyWithImpl<$Res, $Val extends BusinessHours>
    implements $BusinessHoursCopyWith<$Res> {
  _$BusinessHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? open = null,
    Object? close = null,
  }) {
    return _then(_value.copyWith(
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessHoursImplCopyWith<$Res>
    implements $BusinessHoursCopyWith<$Res> {
  factory _$$BusinessHoursImplCopyWith(
          _$BusinessHoursImpl value, $Res Function(_$BusinessHoursImpl) then) =
      __$$BusinessHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String open, String close});
}

/// @nodoc
class __$$BusinessHoursImplCopyWithImpl<$Res>
    extends _$BusinessHoursCopyWithImpl<$Res, _$BusinessHoursImpl>
    implements _$$BusinessHoursImplCopyWith<$Res> {
  __$$BusinessHoursImplCopyWithImpl(
      _$BusinessHoursImpl _value, $Res Function(_$BusinessHoursImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? open = null,
    Object? close = null,
  }) {
    return _then(_$BusinessHoursImpl(
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessHoursImpl extends _BusinessHours {
  const _$BusinessHoursImpl({required this.open, required this.close})
      : super._();

  factory _$BusinessHoursImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessHoursImplFromJson(json);

  @override
  final String open;
  @override
  final String close;

  @override
  String toString() {
    return 'BusinessHours(open: $open, close: $close)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessHoursImpl &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, open, close);

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      __$$BusinessHoursImplCopyWithImpl<_$BusinessHoursImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessHoursImplToJson(
      this,
    );
  }
}

abstract class _BusinessHours extends BusinessHours {
  const factory _BusinessHours(
      {required final String open,
      required final String close}) = _$BusinessHoursImpl;
  const _BusinessHours._() : super._();

  factory _BusinessHours.fromJson(Map<String, dynamic> json) =
      _$BusinessHoursImpl.fromJson;

  @override
  String get open;
  @override
  String get close;

  /// Create a copy of BusinessHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessHoursImplCopyWith<_$BusinessHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CafeStore _$CafeStoreFromJson(Map<String, dynamic> json) {
  return _CafeStore.fromJson(json);
}

/// @nodoc
mixin _$CafeStore {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get area => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  BusinessHours get weekdayHours => throw _privateConstructorUsedError;
  BusinessHours get weekendHours => throw _privateConstructorUsedError;
  List<StoreFeature> get features => throw _privateConstructorUsedError;
  bool get mobileOrder => throw _privateConstructorUsedError;

  /// Live estimate from the server; `null` while closed.
  Congestion? get congestion => throw _privateConstructorUsedError;

  /// Serializes this CafeStore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CafeStoreCopyWith<CafeStore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CafeStoreCopyWith<$Res> {
  factory $CafeStoreCopyWith(CafeStore value, $Res Function(CafeStore) then) =
      _$CafeStoreCopyWithImpl<$Res, CafeStore>;
  @useResult
  $Res call(
      {String id,
      String name,
      String area,
      String address,
      String phone,
      double latitude,
      double longitude,
      BusinessHours weekdayHours,
      BusinessHours weekendHours,
      List<StoreFeature> features,
      bool mobileOrder,
      Congestion? congestion});

  $BusinessHoursCopyWith<$Res> get weekdayHours;
  $BusinessHoursCopyWith<$Res> get weekendHours;
}

/// @nodoc
class _$CafeStoreCopyWithImpl<$Res, $Val extends CafeStore>
    implements $CafeStoreCopyWith<$Res> {
  _$CafeStoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? area = null,
    Object? address = null,
    Object? phone = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? weekdayHours = null,
    Object? weekendHours = null,
    Object? features = null,
    Object? mobileOrder = null,
    Object? congestion = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      weekdayHours: null == weekdayHours
          ? _value.weekdayHours
          : weekdayHours // ignore: cast_nullable_to_non_nullable
              as BusinessHours,
      weekendHours: null == weekendHours
          ? _value.weekendHours
          : weekendHours // ignore: cast_nullable_to_non_nullable
              as BusinessHours,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<StoreFeature>,
      mobileOrder: null == mobileOrder
          ? _value.mobileOrder
          : mobileOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      congestion: freezed == congestion
          ? _value.congestion
          : congestion // ignore: cast_nullable_to_non_nullable
              as Congestion?,
    ) as $Val);
  }

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessHoursCopyWith<$Res> get weekdayHours {
    return $BusinessHoursCopyWith<$Res>(_value.weekdayHours, (value) {
      return _then(_value.copyWith(weekdayHours: value) as $Val);
    });
  }

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessHoursCopyWith<$Res> get weekendHours {
    return $BusinessHoursCopyWith<$Res>(_value.weekendHours, (value) {
      return _then(_value.copyWith(weekendHours: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CafeStoreImplCopyWith<$Res>
    implements $CafeStoreCopyWith<$Res> {
  factory _$$CafeStoreImplCopyWith(
          _$CafeStoreImpl value, $Res Function(_$CafeStoreImpl) then) =
      __$$CafeStoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String area,
      String address,
      String phone,
      double latitude,
      double longitude,
      BusinessHours weekdayHours,
      BusinessHours weekendHours,
      List<StoreFeature> features,
      bool mobileOrder,
      Congestion? congestion});

  @override
  $BusinessHoursCopyWith<$Res> get weekdayHours;
  @override
  $BusinessHoursCopyWith<$Res> get weekendHours;
}

/// @nodoc
class __$$CafeStoreImplCopyWithImpl<$Res>
    extends _$CafeStoreCopyWithImpl<$Res, _$CafeStoreImpl>
    implements _$$CafeStoreImplCopyWith<$Res> {
  __$$CafeStoreImplCopyWithImpl(
      _$CafeStoreImpl _value, $Res Function(_$CafeStoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? area = null,
    Object? address = null,
    Object? phone = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? weekdayHours = null,
    Object? weekendHours = null,
    Object? features = null,
    Object? mobileOrder = null,
    Object? congestion = freezed,
  }) {
    return _then(_$CafeStoreImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      weekdayHours: null == weekdayHours
          ? _value.weekdayHours
          : weekdayHours // ignore: cast_nullable_to_non_nullable
              as BusinessHours,
      weekendHours: null == weekendHours
          ? _value.weekendHours
          : weekendHours // ignore: cast_nullable_to_non_nullable
              as BusinessHours,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<StoreFeature>,
      mobileOrder: null == mobileOrder
          ? _value.mobileOrder
          : mobileOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      congestion: freezed == congestion
          ? _value.congestion
          : congestion // ignore: cast_nullable_to_non_nullable
              as Congestion?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CafeStoreImpl extends _CafeStore {
  const _$CafeStoreImpl(
      {required this.id,
      required this.name,
      required this.area,
      required this.address,
      required this.phone,
      required this.latitude,
      required this.longitude,
      required this.weekdayHours,
      required this.weekendHours,
      final List<StoreFeature> features = const <StoreFeature>[],
      this.mobileOrder = true,
      this.congestion})
      : _features = features,
        super._();

  factory _$CafeStoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$CafeStoreImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String area;
  @override
  final String address;
  @override
  final String phone;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final BusinessHours weekdayHours;
  @override
  final BusinessHours weekendHours;
  final List<StoreFeature> _features;
  @override
  @JsonKey()
  List<StoreFeature> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey()
  final bool mobileOrder;

  /// Live estimate from the server; `null` while closed.
  @override
  final Congestion? congestion;

  @override
  String toString() {
    return 'CafeStore(id: $id, name: $name, area: $area, address: $address, phone: $phone, latitude: $latitude, longitude: $longitude, weekdayHours: $weekdayHours, weekendHours: $weekendHours, features: $features, mobileOrder: $mobileOrder, congestion: $congestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CafeStoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.weekdayHours, weekdayHours) ||
                other.weekdayHours == weekdayHours) &&
            (identical(other.weekendHours, weekendHours) ||
                other.weekendHours == weekendHours) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.mobileOrder, mobileOrder) ||
                other.mobileOrder == mobileOrder) &&
            (identical(other.congestion, congestion) ||
                other.congestion == congestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      area,
      address,
      phone,
      latitude,
      longitude,
      weekdayHours,
      weekendHours,
      const DeepCollectionEquality().hash(_features),
      mobileOrder,
      congestion);

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CafeStoreImplCopyWith<_$CafeStoreImpl> get copyWith =>
      __$$CafeStoreImplCopyWithImpl<_$CafeStoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CafeStoreImplToJson(
      this,
    );
  }
}

abstract class _CafeStore extends CafeStore {
  const factory _CafeStore(
      {required final String id,
      required final String name,
      required final String area,
      required final String address,
      required final String phone,
      required final double latitude,
      required final double longitude,
      required final BusinessHours weekdayHours,
      required final BusinessHours weekendHours,
      final List<StoreFeature> features,
      final bool mobileOrder,
      final Congestion? congestion}) = _$CafeStoreImpl;
  const _CafeStore._() : super._();

  factory _CafeStore.fromJson(Map<String, dynamic> json) =
      _$CafeStoreImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get area;
  @override
  String get address;
  @override
  String get phone;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  BusinessHours get weekdayHours;
  @override
  BusinessHours get weekendHours;
  @override
  List<StoreFeature> get features;
  @override
  bool get mobileOrder;

  /// Live estimate from the server; `null` while closed.
  @override
  Congestion? get congestion;

  /// Create a copy of CafeStore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CafeStoreImplCopyWith<_$CafeStoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
