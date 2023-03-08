// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worktime3/extensions/extensions.dart';

import '../../models/wts_time.dart';
import '../../utility/utility.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/work_time_summary_notifier.dart';

class WorkTimeDisplayPage extends ConsumerWidget {
  WorkTimeDisplayPage({super.key, required this.ym});

  final String ym;

  final Utility _utility = Utility();

  List<WtsTime> wtsTimes = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeWtsList();

    final holidayState = ref.watch(holidayProvider);

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        _utility.getBackGround(),
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, position) {
                  final exYm = ym.split('-');

                  final listdate = DateTime(
                    exYm[0].toInt(),
                    exYm[1].toInt(),
                    position + 1,
                  );

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
                        Expanded(child: Text(wtsTimes[position].day)),
                        Expanded(child: Text(wtsTimes[position].start)),
                        Expanded(child: Text(wtsTimes[position].end)),
                        Expanded(child: Text(wtsTimes[position].work)),
                        Expanded(child: Text(wtsTimes[position].rest)),
                      ],
                    ),
                  );
                },
                childCount: wtsTimes.length,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ///
  void makeWtsList() {
    wtsTimes = [];

    final workTimeSummaryState = _ref.watch(workTimeSummaryProvider);

    workTimeSummaryState.forEach((element) {
      if (ym == element.yearmonth) {
        element.wtsTimes.forEach((element2) {
          wtsTimes.add(element2);
        });
      }
    });
  }
}
