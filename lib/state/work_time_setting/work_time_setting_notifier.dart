import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'work_time_setting_state.dart';

////////////////////////////////////////////////
final workTimeSettingProvider = StateNotifierProvider.autoDispose<
    WorkTimeSettingNotifier, WorkTimeSettingState>((ref) {
  return WorkTimeSettingNotifier(const WorkTimeSettingState());
});

class WorkTimeSettingNotifier extends StateNotifier<WorkTimeSettingState> {
  WorkTimeSettingNotifier(super.state);

  Future<void> setWorkTime({required String flag, required String time}) async {
    switch (flag) {
      case 'start':
        state = state.copyWith(start: time);
        break;
      case 'end':
        state = state.copyWith(end: time);
        break;
    }
  }
}

////////////////////////////////////////////////
