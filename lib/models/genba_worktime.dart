/*
http://toyohide.work/BrainLog/api/getGenbaWorkTime

{
    "data": [
        {
            "company": "SBC",
            "genba": "SBC",
            "start": "10:00",
            "end": "19:00"
        },

*/

class GenbaWorkTime {
  GenbaWorkTime({
    required this.company,
    required this.genba,
    required this.start,
    required this.end,
  });

  factory GenbaWorkTime.fromJson(Map<String, dynamic> json) => GenbaWorkTime(
        company: json['company'].toString(),
        genba: json['genba'].toString(),
        start: json['start'].toString(),
        end: json['end'].toString(),
      );

  String company;
  String genba;
  String start;
  String end;

  Map<String, dynamic> toJson() => {
        'company': company,
        'genba': genba,
        'start': start,
        'end': end,
      };
}
