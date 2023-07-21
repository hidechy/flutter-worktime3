// ignore_for_file: must_be_immutable, cascade_invocations, use_decorated_box

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worktime3/screens/_pages/worktime_result_alert.dart';

import '../viewmodel/work_time_notifier.dart';
import '_pages/work_time_display_page.dart';
import '_pages/worktime_dialog.dart';
import '_pages/worktime_estimate_alert.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  List<TabInfo> tabs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeYmTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //

        appBar: AppBar(
          elevation: 0,
          title: const Text('Work Time'),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      WorktimeDialog(
                        context: context,
                        widget: WorktimeResultAlert(),
                      );
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          Icon(Icons.list),
                          Text('Result'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      WorktimeDialog(
                        context: context,
                        widget: WorktimeEstimateAlert(),
                      );
                    },
                    child: const SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          Icon(Icons.ac_unit),
                          Text('Estimate'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.blueAccent,
            tabs: tabs.map((TabInfo tab) {
              return Tab(text: tab.label);
            }).toList(),
          ),
        ),

        //

        body: TabBarView(
          children: tabs.map((tab) => tab.widget).toList(),
        ),

        //
      ),
    );
  }

  ///
  void makeYmTab() {
    final list = <String>[];

    final workTimeSummaryState = _ref.watch(workTimeSummaryProvider);

    workTimeSummaryState.forEach((element) {
      list.add(element.yearmonth);
    });

    list.sort((a, b) => -1 * a.compareTo(b));

    list.forEach((element) {
      tabs.add(TabInfo(
        element,
        WorkTimeDisplayPage(ym: element),
      ));
    });
  }
}
