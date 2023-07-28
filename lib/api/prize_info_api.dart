import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto_tw/model/prize_info.dart';

class PrizeInfoApi {
  static List<PrizeInfo> prizeInfoFromJson(String str) =>
      List<PrizeInfo>.from(json.decode(str).map((x) => PrizeInfo.fromJson(x)));

  static Future<List<PrizeInfo>?> fetchPrizeInfoGet(
      String drawType, String drawNo) async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/get_prize_info.php?&draw_type=$drawType&draw_no=$drawNo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<PrizeInfo> prizeInfoList = prizeInfoFromJson(response.body);
      return prizeInfoList;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
