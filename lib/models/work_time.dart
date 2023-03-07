/*
http://toyohide.work/BrainLog/api/worktimemonthdata

{
    "data": [
        {
            "date": "2023-03-01",
            "work_start": "10:00",
            "work_end": "19:00"
        },

*/

class WorkTime {
  WorkTime({
    required this.date,
    required this.workStart,
    required this.workEnd,
  });

  factory WorkTime.fromJson(Map<String, dynamic> json) => WorkTime(
        date: DateTime.parse(json['date'].toString()),
        workStart: json['work_start'].toString(),
        workEnd: json['work_end'].toString(),
      );

  DateTime date;
  String workStart;
  String workEnd;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'work_start': workStart,
        'work_end': workEnd,
      };
}
