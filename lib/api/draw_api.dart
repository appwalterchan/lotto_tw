import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto_tw/model/draw.dart';

class DrawApi {
  static List<Draw> drawFromJson(String str) =>
      List<Draw>.from(json.decode(str).map((x) => Draw.fromJson(x)));

  static Future<List<Draw>?> fetchAllLottoListGet(String drawType) async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/all_lotto_list.php?draw_type=$drawType');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Draw>?> fetchBigLottoListGet() async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/big_lotto_list.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Draw>?> fetchPowerBallListGet() async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/power_ball_list.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Draw>?> fetchDoubleWinListGet() async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/doublewin_reslut.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Draw>?> fetchStarLottoListGet() async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/star_lotto_list.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Draw>?> fetchTodayLottoListGet() async {
    var url = Uri.parse(
        'https://hkdailylife.com/lotto/taiwan/lotto_all/star_lotto_list.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Draw> draws = drawFromJson(response.body);
      return draws;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
