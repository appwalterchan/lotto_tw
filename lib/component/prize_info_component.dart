import 'package:flutter/material.dart';
import 'package:lotto_tw/model/prize_info.dart';

import '../constant/app_constants.dart';

Widget prizeInfoComponent(double textScale, int flexNo1, PrizeInfo pd) {
  return SizedBox(
      child: Card(
          elevation: 5,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: flexNo1,
                      child: Text(
                        pd.prize,
                        style: TextStyle(
                          fontSize: AppConstants.fontSizeLarge * textScale,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(pd.prizeAmount,
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeLarge * textScale,
                          ),
                          textAlign: TextAlign.end),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(pd.prizeUnit,
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeLarge * textScale,
                          ),
                          textAlign: TextAlign.end),
                    )
                  ]))));
}
