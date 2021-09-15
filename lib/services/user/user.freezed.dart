// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String id,
      String firstName = '',
      String lastName = '',
      List<String> watched = const [],
      List<String> watchlist = const [],
      List<String> lists = const [],
      required DateTime createdAt,
      required DateTime updatedAt}) {
    return _User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      watched: watched,
      watchlist: watchlist,
      lists: lists,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  List<String> get watched => throw _privateConstructorUsedError;
  List<String> get watchlist => throw _privateConstructorUsedError;
  List<String> get lists => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String firstName,
      String lastName,
      List<String> watched,
      List<String> watchlist,
      List<String> lists,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? watched = freezed,
    Object? watchlist = freezed,
    Object? lists = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      watched: watched == freezed
          ? _value.watched
          : watched // ignore: cast_nullable_to_non_nullable
              as List<String>,
      watchlist: watchlist == freezed
          ? _value.watchlist
          : watchlist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lists: lists == freezed
          ? _value.lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String firstName,
      String lastName,
      List<String> watched,
      List<String> watchlist,
      List<String> lists,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? watched = freezed,
    Object? watchlist = freezed,
    Object? lists = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_User(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      watched: watched == freezed
          ? _value.watched
          : watched // ignore: cast_nullable_to_non_nullable
              as List<String>,
      watchlist: watchlist == freezed
          ? _value.watchlist
          : watchlist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lists: lists == freezed
          ? _value.lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  _$_User(
      {required this.id,
      this.firstName = '',
      this.lastName = '',
      this.watched = const [],
      this.watchlist = const [],
      this.lists = const [],
      required this.createdAt,
      required this.updatedAt});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String id;
  @JsonKey(defaultValue: '')
  @override
  final String firstName;
  @JsonKey(defaultValue: '')
  @override
  final String lastName;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> watched;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> watchlist;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> lists;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, watched: $watched, watchlist: $watchlist, lists: $lists, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.watched, watched) ||
                const DeepCollectionEquality()
                    .equals(other.watched, watched)) &&
            (identical(other.watchlist, watchlist) ||
                const DeepCollectionEquality()
                    .equals(other.watchlist, watchlist)) &&
            (identical(other.lists, lists) ||
                const DeepCollectionEquality().equals(other.lists, lists)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(watched) ^
      const DeepCollectionEquality().hash(watchlist) ^
      const DeepCollectionEquality().hash(lists) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  factory _User(
      {required String id,
      String firstName,
      String lastName,
      List<String> watched,
      List<String> watchlist,
      List<String> lists,
      required DateTime createdAt,
      required DateTime updatedAt}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  List<String> get watched => throw _privateConstructorUsedError;
  @override
  List<String> get watchlist => throw _privateConstructorUsedError;
  @override
  List<String> get lists => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
