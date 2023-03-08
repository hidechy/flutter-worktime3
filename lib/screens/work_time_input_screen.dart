import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utility/utility.dart';

class WorkTimeInputScreen extends ConsumerWidget {
  WorkTimeInputScreen({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  void displayTimePicker({required String flag}) async {
    final selectedTime = await showTimePicker(
      context: _context,

      initialTime: TimeOfDay.now(),

      //
      //
      // initialTime: (widget.start != '')
      //     ? TimeOfDay(
      //   hour: int.parse(widget.start.split(":")[0]),
      //   minute: int.parse(widget.start.split(":")[1]),
      // )
      //     : TimeOfDay.now(),
      //
      //
      //

      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (selectedTime != null) {
      // _dialogSelectedStartTime =
      // '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
      // setState(() {});
    }
  }
}
