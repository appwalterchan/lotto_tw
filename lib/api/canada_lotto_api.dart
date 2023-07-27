import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto_tw/model/canada_lotto.dart';

class CanadaLottoApi {
  static List<CanadaLotto> canadaLottoFromJson(String str) =>
      List<CanadaLotto>.from(
          json.decode(str).map((x) => CanadaLotto.fromJson(x)));

  static Future<List<CanadaLotto>?> fetchCanadaLottoGet(String drawType) async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/canada_lotto/lotto649/lotto_list_result.php?draw_type=$drawType');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<CanadaLotto> canadaLottos = canadaLottoFromJson(response.body);
      return canadaLottos;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
