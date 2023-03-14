// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_param_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppParamState {
  String get ym => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppParamStateCopyWith<AppParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppParamStateCopyWith<$Res> {
  factory $AppParamStateCopyWith(
          AppParamState value, $Res Function(AppParamState) then) =
      _$AppParamStateCopyWithImpl<$Res, AppParamState>;
  @useResult
  $Res call({String ym});
}

/// @nodoc
class _$AppParamStateCopyWithImpl<$Res, $Val extends AppParamState>
    implements $AppParamStateCopyWith<$Res> {
  _$AppParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ym = null,
  }) {
    return _then(_value.copyWith(
      ym: null == ym
          ? _value.ym
          : ym // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppParamStateCopyWith<$Res>
    implements $AppParamStateCopyWith<$Res> {
  factory _$$_AppParamStateCopyWith(
          _$_AppParamState value, $Res Function(_$_AppParamState) then) =
      __$$_AppParamStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ym});
}

/// @nodoc
class __$$_AppParamStateCopyWithImpl<$Res>
    extends _$AppParamStateCopyWithImpl<$Res, _$_AppParamState>
    implements _$$_AppParamStateCopyWith<$Res> {
  __$$_AppParamStateCopyWithImpl(
      _$_AppParamState _value, $Res Function(_$_AppParamState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ym = null,
  }) {
    return _then(_$_AppParamState(
      ym: null == ym
          ? _value.ym
          : ym // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppParamState implements _AppParamState {
  const _$_AppParamState({this.ym = ''});

  @override
  @JsonKey()
  final String ym;

  @override
  String toString() {
    return 'AppParamState(ym: $ym)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppParamState &&
            (identical(other.ym, ym) || other.ym == ym));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ym);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppParamStateCopyWith<_$_AppParamState> get copyWith =>
      __$$_AppParamStateCopyWithImpl<_$_AppParamState>(this, _$identity);
}

abstract class _AppParamState implements AppParamState {
  const factory _AppParamState({final String ym}) = _$_AppParamState;

  @override
  String get ym;
  @override
  @JsonKey(ignore: true)
  _$$_AppParamStateCopyWith<_$_AppParamState> get copyWith =>
      throw _privateConstructorUsedError;
}
