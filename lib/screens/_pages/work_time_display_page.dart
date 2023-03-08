// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/wts_item.dart';
import '../../models/wts_time.dart';
import '../../utility/utility.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/work_time_notifier.dart';

class WorkTimeDisplayPage extends ConsumerWidget {
  WorkTimeDisplayPage({super.key, required this.ym});

  final String ym;

  final Utility _utility = Utility();

  late WtsItem wtsItem;

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
                  var pos = position - 1;

                  final exYm = ym.split('-');

                  final listdate = DateTime(
                    exYm[0].toInt(),
                    exYm[1].toInt(),
                    position,
                  );

                  if (position == 0) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
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
                          Container(
                            padding: EdgeInsets.all(5),
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
                        ],
                      ),
                    );
                  }

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
                                      child: Text(wtsTimes[pos].start),
                                    ),
                                    Expanded(
                                      child: Text(wtsTimes[pos].end),
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
                          onPressed: () {},
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
  void makeWtsList() {
    wtsTimes = [];

    final workTimeSummaryState = _ref.watch(workTimeSummaryProvider);

    workTimeSummaryState.forEach((element) {
      if (ym == element.yearmonth) {
        wtsItem = element;

        element.wtsTimes.forEach((element2) {
          wtsTimes.add(element2);
        });
      }
    });
  }
}