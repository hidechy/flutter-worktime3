import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_time_setting_state.freezed.dart';

@freezed
class WorkTimeSettingState with _$WorkTimeSettingState {
  const factory WorkTimeSettingState({
    @Default('') String start,
    @Default('') String end,
  }) = _WorkTimeSettingState;
}
