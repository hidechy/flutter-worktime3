// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/work_time_setting/work_time_setting_notifier.dart';
import '../utility/utility.dart';

class WorkTimeInputScreen extends ConsumerWidget {
  WorkTimeInputScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    _context = context;

    final workTimeSettingState = ref.watch(workTimeSettingProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(20),
                color: Colors.black.withOpacity(0.3),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 80,
                            child: Text('Work Start'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.access_time),

                              onPressed: () {
                                displayTimePicker(flag: 'start');
                              },
                              // onPressed: () =>
                              //     _showStartTimePicker(context: context),
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(workTimeSettingState.start),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 80,
                            child: Text('Work End'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.access_time),

                              onPressed: () {
                                displayTimePicker(flag: 'end');
                              },
                              // onPressed: () =>
                              //     _showEndTimePicker(context: context),
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(workTimeSettingState.end),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.greenAccent.withOpacity(0.3),
                          ),
                          child: const Icon(Icons.input),
                          onPressed: () {},
//                          onPressed: () => _uploadWorktimeData(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Future<void> displayTimePicker({required String flag}) async {
    final workTimeSettingState = _ref.watch(workTimeSettingProvider);

    final time = (flag == 'start')
        ? workTimeSettingState.start
        : workTimeSettingState.end;

    final selectedTime = await showTimePicker(
      context: _context,
      initialTime: (time != '')
          ? TimeOfDay(
              hour: time.split(':')[0].toInt(),
              minute: time.split(':')[1].toInt(),
            )
          : TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (selectedTime != null) {
      await _ref.watch(workTimeSettingProvider.notifier).setWorkTime(
            flag: flag,
            time:
                '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
          );
    }
  }
}
