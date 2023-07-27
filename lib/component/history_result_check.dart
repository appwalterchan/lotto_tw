import 'package:flutter/material.dart';

import '../model/canada_lotto.dart';
import 'lotto_num_hit.dart';

Widget historyResultCheck(
    CanadaLotto lotto, double textScale, List<String> checkNumbers) {
  String drawType = lotto.drawType;
  double fontSize = drawType != '1' ? 50 : 48;
  return Row(children: [
    lottoNumHit(lotto.num1, textScale, fontSize,
        checkNumbers.contains(lotto.num1), false),
    lottoNumHit(lotto.num2, textScale, fontSize,
        checkNumbers.contains(lotto.num2), false),
    lottoNumHit(lotto.num3, textScale, fontSize,
        checkNumbers.contains(lotto.num3), false),
    lottoNumHit(lotto.num4, textScale, fontSize,
        checkNumbers.contains(lotto.num4), false),
    lottoNumHit(lotto.num5, textScale, fontSize,
        checkNumbers.contains(lotto.num5), false),
    lottoNumHit(lotto.num6, textScale, fontSize,
        checkNumbers.contains(lotto.num6), false),
    lottoNumHit(lotto.num7, textScale, fontSize,
        checkNumbers.contains(lotto.num7), false),
    SizedBox(
      width: fontSize / 4,
    ),
    lottoNumHit(lotto.bonus, textScale, fontSize,
        checkNumbers.contains(lotto.bonus), true),
  ]);
}
