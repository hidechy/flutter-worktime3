// ignore_for_file: must_be_immutable, cascade_invocations, depend_on_referenced_packages
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/genba_worktime.dart';
import '../../models/wts_item.dart';
import '../../models/wts_time.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/work_time_setting/work_time_setting_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/work_time_notifier.dart';
import '../work_time_input_screen.dart';

class WorkTimeDisplayPage extends HookConsumerWidget {
  WorkTimeDisplayPage({super.key, required this.ym});

  final String ym;

  final Utility _utility = Utility();

  late WtsItem wtsItem;

  List<WtsTime> wtsTimes = [];

  Map<String, String> startEndMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeWtsList();

    final holidayState = ref.watch(holidayProvider);

    useEffect(() {
      Future.microtask(() async {
        await ref.watch(appParamProvider.notifier).setYm(ym: ym);
      });

      return null;
    }, []);

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        _utility.getBackGround(),
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, position) {
                  final pos = position - 1;

                  final exYm = ym.split('-');

                  final listdate =
                      DateTime(exYm[0].toInt(), exYm[1].toInt(), position);

                  //-------------------------//
                  if (position == 0) {
                    return makeGenbaInfoWidget();
                  }
                  //-------------------------//

                  final start = wtsTimes[pos].start;
                  final end = wtsTimes[pos].end;

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      color: _utility.getYoubiColor(
                        date: listdate,
                        youbiStr: listdate.youbiStr,
                        holiday: holidayState.data,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(wtsTimes[pos].day)),
                        Expanded(
                          flex: 4,
                          child: (wtsTimes[pos].start == '')
                              ? Container(
                                  alignment: Alignment.topRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Text('holiday'),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        start,
                                        style: TextStyle(
                                          color: (start != startEndMap['start'])
                                              ? Colors.yellowAccent
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        end,
                                        style: TextStyle(
                                          color: (end != startEndMap['end'])
                                              ? Colors.yellowAccent
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(wtsTimes[pos].work),
                                    ),
                                    Expanded(
                                      child: Text(wtsTimes[pos].rest),
                                    ),
                                  ],
                                ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (start != '') {
                              ref
                                  .watch(workTimeSettingProvider.notifier)
                                  .setWorkTime(flag: 'start', time: start);
                            }

                            if (end != '') {
                              ref
                                  .watch(workTimeSettingProvider.notifier)
                                  .setWorkTime(flag: 'end', time: end);
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WorkTimeInputScreen(date: listdate),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: wtsTimes.length + 1,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ///
  Widget makeGenbaInfoWidget() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(wtsItem.company),
          Text(wtsItem.genba),

          //

          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(wtsItem.workSum),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text((wtsItem.salary == '')
                        ? ''
                        : wtsItem.salary.toCurrency()),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text((wtsItem.hourSalary == '')
                        ? ''
                        : wtsItem.hourSalary.toCurrency()),
                  ),
                ),
              ],
            ),
          ),

          //

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Row(
                children: [
                  Text((startEndMap['start'] == null)
                      ? ''
                      : startEndMap['start']!),
                  const SizedBox(width: 10),
                  const Text('〜'),
                  const SizedBox(width: 10),
                  Text((startEndMap['end'] == null) ? '' : startEndMap['end']!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  void makeWtsList() {
    wtsTimes = [];
    startEndMap = {};

    /////////////////////////////////////
    final genbaWorkTimeState = _ref.watch(genbaWorkTimeProvider);

    final timeMap = <String, GenbaWorkTime>{};
    genbaWorkTimeState.forEach((element) {
      timeMap['${element.company}|${element.genba}'] = element;
    });
    /////////////////////////////////////

    final workTimeSummaryState = _ref.watch(workTimeSummaryProvider);

    workTimeSummaryState.forEach((element) {
      if (ym == element.yearmonth) {
        wtsItem = element;

        element.wtsTimes.forEach((element2) {
          wtsTimes.add(element2);
        });

        if (timeMap['${element.company}|${element.genba}'] != null) {
          startEndMap['start'] =
              timeMap['${element.company}|${element.genba}']!.start;
          startEndMap['end'] =
              timeMap['${element.company}|${element.genba}']!.end;
        }
      }
    });
  }
}
