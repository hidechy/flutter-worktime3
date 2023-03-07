// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worktime3/models/wts_time.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/wts_item.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final workTimeSummaryProvider =
    StateNotifierProvider.autoDispose<WorkTimeSummaryNotifier, List<WtsItem>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return WorkTimeSummaryNotifier([], client, utility)..getWorkTimeSummary();
});

class WorkTimeSummaryNotifier extends StateNotifier<List<WtsItem>> {
  WorkTimeSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getWorkTimeSummary() async {
    await client.post(path: APIPath.worktimesummary).then((value) {
      final list = <WtsItem>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exValue = value['data'][i].toString().split(';');

        final listItem = exValue[exValue.length].split('/');

        final list2 = <WtsTime>[];
        listItem.forEach((element) {
          final exElement = element.split('|');

          list2.add(
            WtsTime(
              day: exElement[0],
              start: exElement[1],
              end: exElement[2],
              work: exElement[3],
              rest: exElement[4],
              youbiNum: exElement[5].toInt(),
            ),
          );
        });

        list.add(
          WtsItem(
            yearmonth: exValue[0],
            workSum: exValue[1],
            company: exValue[2],
            genba: exValue[3],
            salary: exValue[4].toInt(),
            hourSalary: exValue[5].toInt(),
            wtsTimes: list2,
          ),
        );
      }

      state = list;

      /*
http://toyohide.work/BrainLog/api/worktimesummary

{
    "data": [
        "2014-10;102.75;SBC;SBC;171732;1671;01(水)|||||3|0/02(木)|||||4|0/03(金)|||||5|0/04(土)|||||6|0/05(日)|||||0|0/06(月)|||||1|0/07(火)|||||2|0/08(水)|||||3|0/09(木)|||||4|0/10(金)|||||5|0/11(土)|||||6|0/12(日)|||||0|0/13(月)|||||1|0/14(火)|||||2|0/15(水)|10:00|19:00|8.0|60|3|0/16(木)|10:00|19:00|8.0|60|4|0/17(金)|10:00|19:00|8.0|60|5|0/18(土)|||||6|0/19(日)|||||0|0/20(月)|10:00|19:00|8.0|60|1|0/21(火)|10:00|19:00|8.0|60|2|0/22(水)|10:00|19:00|8.0|60|3|0/23(木)|10:00|19:00|8.0|60|4|0/24(金)|10:00|19:00|8.0|60|5|0/25(土)|||||6|0/26(日)|||||0|0/27(月)|10:00|19:00|8.0|60|1|0/28(火)|10:00|19:00|8.0|60|2|0/29(水)|10:00|19:00|8.0|60|3|0/30(木)|10:00|19:00|8.0|60|4|0/31(金)|11:15|19:00|6.75|60|5|1",
        "2014-11;
        144.0;
        SBC;
        大門;
        318319;
        2210;

        01(土)|||||6|0/
        02(日)|||||0|0/
        03(月)|||||1|0/
        04(火)|09:00|18:00|8.0|60|2|0/
        05(水)|09:00|18:00|8.0|60|3|0/06(木)|09:00|18:00|8.0|60|4|0/07(金)|09:00|18:00|8.0|60|5|0/08(土)|||||6|0/09(日)|||||0|0/10(月)|09:00|18:00|8.0|60|1|0/11(火)|09:00|18:00|8.0|60|2|0/12(水)|09:00|18:00|8.0|60|3|0/13(木)|09:00|18:00|8.0|60|4|0/14(金)|09:00|18:00|8.0|60|5|0/15(土)|||||6|0/16(日)|||||0|0/17(月)|09:00|18:00|8.0|60|1|0/18(火)|09:00|18:00|8.0|60|2|0/19(水)|09:00|18:00|8.0|60|3|0/20(木)|09:00|18:00|8.0|60|4|0/21(金)|09:00|18:00|8.0|60|5|0/22(土)|||||6|0/23(日)|||||0|0/24(月)|||||1|0/25(火)|09:00|18:00|8.0|60|2|0/26(水)|09:00|18:00|8.0|60|3|0/27(木)|09:00|18:00|8.0|60|4|0/28(金)|09:00|18:00|8.0|60|5|0/29(土)|||||6|0/30(日)|||||0|0",



        "2014-12;138.5;SBC;新宿;380774;2749;01(月)|09:00|18:00|8.0|60|1|0/02(火)|09:00|18:00|8.0|60|2|0/03(水)|09:00|18:00|8.0|60|3|0/04(木)|09:00|18:00|8.0|60|4|0/05(金)|09:00|18:00|8.0|60|5|0/06(土)|||||6|0/07(日)|||||0|0/08(月)|09:00|18:00|8.0|60|1|0/09(火)|09:00|18:00|8.0|60|2|0/10(水)|09:00|18:00|8.0|60|3|0/11(木)|||||4|0/12(金)|||||5|0/13(土)|||||6|0/14(日)|||||0|0/15(月)|||||1|0/16(火)|09:00|18:00|8.0|60|2|0/17(水)|09:00|19:00|9.0|60|3|0/18(木)|09:00|18:00|8.0|60|4|0/19(金)|09:00|18:30|8.5|60|5|0/20(土)|||||6|0/21(日)|||||0|0/22(月)|09:00|18:30|8.5|60|1|0/23(火)|||||2|0/24(水)|09:00|18:00|8.0|60|3|0/25(木)|09:00|18:30|8.5|60|4|0/26(金)|09:00|18:00|8.0|60|5|0/27(土)|||||6|0/28(日)|||||0|0/29(月)|09:00|18:00|8.0|60|1|0/30(火)|||||2|0/31(水)|||||3|0",

*/

      // final list = <Category>[];
      //
      // final getCategory = <String>[];
      // for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
      //   final category1 = value['data'][i]['category1'].toString();
      //
      //   //---
      //   if (!getCategory.contains(category1)) {
      //     list.add(
      //       Category(
      //         category1: value['data'][i]['category1'].toString(),
      //         category2: value['data'][i]['category2'].toString(),
      //         bunrui: value['data'][i]['bunrui'].toString(),
      //       ),
      //     );
      //   }
      //
      //   getCategory.add(category1);
      // }
      //
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
