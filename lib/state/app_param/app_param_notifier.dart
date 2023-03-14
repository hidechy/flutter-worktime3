import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';

import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  return AppParamNotifier(AppParamState(
    ym: DateTime.now().yyyymm,
  ));
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  Future<void> setYm({required String ym}) async =>
      state = state.copyWith(ym: ym);
}

////////////////////////////////////////////////
