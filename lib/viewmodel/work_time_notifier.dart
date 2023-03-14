// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worktime3/state/work_time_setting/work_time_setting_notifier.dart';
import 'package:worktime3/state/work_time_setting/work_time_setting_state.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/genba_worktime.dart';
import '../models/wts_item.dart';
import '../models/wts_time.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final workTimeSummaryProvider =
    StateNotifierProvider.autoDispose<WorkTimeSummaryNotifier, List<WtsItem>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return WorkTimeSummaryNotifier([], client, utility)..getWorkTimeSummary();
});

class WorkTimeSummaryNotifier extends StateNotifier<List<WtsItem>> {
  WorkTimeSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getWorkTimeSummary() async {
    await client.post(path: APIPath.worktimesummary).then((value) {
      final list = <WtsItem>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exValue = value['data'][i].toString().split(';');

        final listItem = exValue[exValue.length - 1].split('/');

        final list2 = <WtsTime>[];
        listItem.forEach((element) {
          final exElement = element.split('|');

          list2.add(
            WtsTime(
              day: exElement[0],
              start: exElement[1],
              end: exElement[2],
              work: exElement[3],
              rest: exElement[4],
              youbiNum: exElement[5],
            ),
          );
        });

        list.add(
          WtsItem(
            yearmonth: exValue[0],
            workSum: exValue[1],
            company: exValue[2],
            genba: exValue[3],
            salary: exValue[4],
            hourSalary: exValue[5],
            wtsTimes: list2,
          ),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final genbaWorkTimeProvider = StateNotifierProvider.autoDispose<
    GenbaWorkTimeNotifier, List<GenbaWorkTime>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return GenbaWorkTimeNotifier([], client, utility)..getWorkTime();
});

class GenbaWorkTimeNotifier extends StateNotifier<List<GenbaWorkTime>> {
  GenbaWorkTimeNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getWorkTime() async {
    await client.post(path: APIPath.getGenbaWorkTime).then((value) {
      final list = <GenbaWorkTime>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
            GenbaWorkTime.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
final workTimeInputProvider =
    StateNotifierProvider.autoDispose<WorkTimeInputNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  final workTimeSettingState = ref.watch(workTimeSettingProvider);

  final utility = Utility();

  return WorkTimeInputNotifier(0, client, utility, workTimeSettingState);
});

class WorkTimeInputNotifier extends StateNotifier<int> {
  WorkTimeInputNotifier(
      super.state, this.client, this.utility, this.workTimeSettingState);

  final HttpClient client;
  final Utility utility;
  final WorkTimeSettingState workTimeSettingState;

  ///
  Future<void> inputWorkTime({required DateTime date}) async {
    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['work_start'] = workTimeSettingState.start;
    uploadData['work_end'] = workTimeSettingState.end;

    await client
        .post(path: APIPath.worktimeinsert, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
