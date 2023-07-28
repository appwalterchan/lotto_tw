import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto_tw/model/hot_cold_number.dart';

class HotColdNumberApi {
  static List<HotColdNumber> hotColdNumberFromJson(String str) =>
      List<HotColdNumber>.from(
          json.decode(str).map((x) => HotColdNumber.fromJson(x)));

  static Future<List<HotColdNumber>?> fetchHotColdNumberGet(
      String drawType) async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/hot_cold_number_draw_type.php?draw_type=$drawType');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<HotColdNumber> list = hotColdNumberFromJson(response.body);
      return list;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
