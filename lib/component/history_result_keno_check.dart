import 'package:flutter/material.dart';

import '../model/canada_lotto.dart';
import 'lotto_num_hit.dart';

Widget historyResultKenoCheck(
    CanadaLotto lotto, double textScale, List<String> checkNumbers) {
  double fontSize = 42;
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      children: [
        Row(children: [
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
          lottoNumHit(lotto.num8, textScale, fontSize,
              checkNumbers.contains(lotto.num8), false),
          lottoNumHit(lotto.num9, textScale, fontSize,
              checkNumbers.contains(lotto.num9), false),
          lottoNumHit(lotto.num10, textScale, fontSize,
              checkNumbers.contains(lotto.num10), false),
        ]),
        Row(children: [
          lottoNumHit(lotto.num11, textScale, fontSize,
              checkNumbers.contains(lotto.num11), false),
          lottoNumHit(lotto.num12, textScale, fontSize,
              checkNumbers.contains(lotto.num12), false),
          lottoNumHit(lotto.num13, textScale, fontSize,
              checkNumbers.contains(lotto.num13), false),
          lottoNumHit(lotto.num14, textScale, fontSize,
              checkNumbers.contains(lotto.num14), false),
          lottoNumHit(lotto.num15, textScale, fontSize,
              checkNumbers.contains(lotto.num15), false),
          lottoNumHit(lotto.num16, textScale, fontSize,
              checkNumbers.contains(lotto.num16), false),
          lottoNumHit(lotto.num17, textScale, fontSize,
              checkNumbers.contains(lotto.num17), false),
          lottoNumHit(lotto.num18, textScale, fontSize,
              checkNumbers.contains(lotto.num18), false),
          lottoNumHit(lotto.num19, textScale, fontSize,
              checkNumbers.contains(lotto.num19), false),
          lottoNumHit(lotto.num20, textScale, fontSize,
              checkNumbers.contains(lotto.num20), false),
        ]),
      ],
    ),
  );
}
