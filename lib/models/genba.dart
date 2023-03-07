/*
http://toyohide.work/BrainLog/api/workinggenbaname

{
    "data": [
        {
            "yearmonth": "1999-10",
            "company": "マリオ",
            "genba": "マリオ"
        },

*/

class Genba {
  Genba({
    required this.yearmonth,
    required this.company,
    required this.genba,
  });

  factory Genba.fromJson(Map<String, dynamic> json) => Genba(
        yearmonth: json['yearmonth'].toString(),
        company: json['company'].toString(),
        genba: json['genba'].toString(),
      );

  String yearmonth;
  String company;
  String genba;

  Map<String, dynamic> toJson() => {
        'yearmonth': yearmonth,
        'company': company,
        'genba': genba,
      };
}
