// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/genba_worktime.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/work_time_notifier.dart';

class WorktimeEstimateAlert extends ConsumerWidget {
  WorktimeEstimateAlert({super.key});

  late String ym;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    ym = ref.watch(appParamProvider.select((value) => value.ym));

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Text(ym),
              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 2,
              ),
              Expanded(
                child: displayData(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayData() {
    final list = <Widget>[];

    /////////////////////////////////////
    final genbaWorkTimeState = _ref.watch(genbaWorkTimeProvider);

    final timeMap = <String, GenbaWorkTime>{};
    genbaWorkTimeState.forEach((element) {
      timeMap['${element.company}|${element.genba}'] = element;
    });
    /////////////////////////////////////

    final holidayState = _ref.watch(holidayProvider);

    final workTimeSummaryState = _ref.watch(workTimeSummaryProvider);

    var total = 0.0;

    workTimeSummaryState.forEach((element) {
      if (element.yearmonth == ym) {
        var genbaStart = '';
        var genbaEnd = '';

        if (timeMap['${element.company}|${element.genba}'] != null) {
          genbaStart = timeMap['${element.company}|${element.genba}']!.start;
          genbaEnd = timeMap['${element.company}|${element.genba}']!.end;
        }

        element.wtsTimes.forEach((element2) {
          final ymd = DateTime(
            ym.split('-')[0].toInt(),
            ym.split('-')[1].toInt(),
            element2.day.split('(')[0].toInt(),
          );

          var dispData = <String>[
            element2.day,
            element2.start,
            element2.end,
            element2.work
          ];

          if (holidayState.data.contains(ymd) ||
              (ymd.youbiStr == 'Saturday' || ymd.youbiStr == 'Sunday')) {
            dispData = [element2.day, '', '', 'holiday'];
          } else {
            //当月のこの後の日付
            if (dispData[1] == '') {
              dispData = [element2.day, genbaStart, genbaEnd, '8.0'];
            }
          }

          if (double.tryParse(dispData[3]) != null) {
            total += dispData[3].toDouble() * 60;
          }

          final color = (DateTime.now().isBefore(ymd))
              ? Colors.transparent
              : Colors.yellowAccent.withOpacity(0.1);

          list.add(
            DecoratedBox(
              decoration: BoxDecoration(
                color: color,
              ),
              child: Row(
                children: dispData.map((e) {
                  return Expanded(child: Text(e));
                }).toList(),
              ),
            ),
          );
        });
      }
    });

    list.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.yellowAccent.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              child: Text((total / 60).toString()),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
