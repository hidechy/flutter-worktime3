import 'wts_time.dart';

class WtsItem {
  WtsItem({
    required this.yearmonth,
    required this.workSum,
    required this.company,
    required this.genba,
    required this.salary,
    required this.hourSalary,
    required this.wtsTimes,
  });

  String yearmonth;
  String workSum;
  String company;
  String genba;
  String salary;
  String hourSalary;
  List<WtsTime> wtsTimes;
}
