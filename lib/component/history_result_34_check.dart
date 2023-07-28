import 'package:flutter/material.dart';

import '../model/draw.dart';
import 'lotto_num_hit.dart';

Widget historyResult34Check(
    Draw lotto, double textScale, List<String> checkNumbers) {
  double fontSize = 42;
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      children: [
        Row(children: [
          lottoNumHit(lotto.no4, textScale, fontSize,
              checkNumbers.contains(lotto.no4), false),
          lottoNumHit(lotto.no5, textScale, fontSize,
              checkNumbers.contains(lotto.no5), false),
          lottoNumHit(lotto.no6, textScale, fontSize,
              checkNumbers.contains(lotto.no6), false),
          lottoNumHit(lotto.no7, textScale, fontSize,
              checkNumbers.contains(lotto.no7), false),
          const SizedBox(
            width: 200,
          ),
          lottoNumHit(lotto.no1, textScale, fontSize,
              checkNumbers.contains(lotto.no1), false),
          lottoNumHit(lotto.no2, textScale, fontSize,
              checkNumbers.contains(lotto.no2), false),
          lottoNumHit(lotto.no3, textScale, fontSize,
              checkNumbers.contains(lotto.no3), false),
        ]),
      ],
    ),
  );
}
