import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto_tw/model/prize_data.dart';

class PrizeDataApi {
  static List<PrizeData> prizeDataFromJson(String str) =>
      List<PrizeData>.from(json.decode(str).map((x) => PrizeData.fromJson(x)));

  static Future<List<PrizeData>?> fetchPrizeDataGet(
      String drawType, DateTime? drawDate) async {
    String base64DrawDate =
        base64.encode(utf8.encode(drawDate.toString().substring(0, 10)));
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/canada_lotto/lotto649/get_prize_info.php?&draw_type=$drawType&draw_date=$base64DrawDate');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // debugPrint("line 490 ${response.body}");
      List<PrizeData> prizeDataList = prizeDataFromJson(response.body);
      return prizeDataList;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
