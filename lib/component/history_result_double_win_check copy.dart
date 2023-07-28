import 'package:flutter/material.dart';

import '../model/draw.dart';
import 'lotto_num_hit.dart';

Widget historyResultDoubleWinCheck(
    Draw lotto, double textScale, List<String> checkNumbers) {
  double fontSize = 42;
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      children: [
        Row(children: [
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
        ]),
        Row(children: [
          lottoNumHit(lotto.no7, textScale, fontSize,
              checkNumbers.contains(lotto.no7), false),
          lottoNumHit(lotto.no8, textScale, fontSize,
              checkNumbers.contains(lotto.no8), false),
          lottoNumHit(lotto.no9, textScale, fontSize,
              checkNumbers.contains(lotto.no9), false),
          lottoNumHit(lotto.no10, textScale, fontSize,
              checkNumbers.contains(lotto.no10), false),
          lottoNumHit(lotto.no11, textScale, fontSize,
              checkNumbers.contains(lotto.no11), false),
          lottoNumHit(lotto.no12, textScale, fontSize,
              checkNumbers.contains(lotto.no12), false),
        ]),
      ],
    ),
  );
}
