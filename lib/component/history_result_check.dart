import 'package:flutter/material.dart';

import '../model/draw.dart';
import 'lotto_num_hit.dart';

Widget historyResultCheck(
    Draw lotto, double textScale, List<String> checkNumbers) {
  String drawType = lotto.drawType;
  double fontSize = drawType != '1' ? 50 : 48;
  return Row(children: [
    lottoNumHit(lotto.no1, textScale, fontSize,
        checkNumbers.contains(lotto.no1), false),
    lottoNumHit(lotto.no2, textScale, fontSize,
        checkNumbers.contains(lotto.no2), false),
    lottoNumHit(lotto.no3, textScale, fontSize,
        checkNumbers.contains(lotto.no3), false),
    lottoNumHit(lotto.no4, textScale, fontSize,
        checkNumbers.contains(lotto.no4), false),
    lottoNumHit(lotto.no5, textScale, fontSize,
        checkNumbers.contains(lotto.no5), false),
    lottoNumHit(lotto.no6, textScale, fontSize,
        checkNumbers.contains(lotto.no6), false),
    SizedBox(
      width: fontSize / 4,
    ),
    lottoNumHit(
        lotto.no7, textScale, fontSize, checkNumbers.contains(lotto.no7), true),
  ]);
}
