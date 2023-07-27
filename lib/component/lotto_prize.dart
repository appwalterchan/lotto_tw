import 'package:flutter/material.dart';
import 'package:lotto_tw/model/prize_data.dart';

import '../constant/app_constants.dart';

Widget lottoPrize(double textScale, int flexNo1, PrizeData pd) {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pd.match,
                            style: TextStyle(
                              fontSize: AppConstants.fontSizeLarge * textScale,
                            ),
                          ),
                          pd.drawDateType.isNotEmpty
                              ? Text(
                                  pd.drawDateType,
                                  style: TextStyle(
                                    fontSize:
                                        AppConstants.fontSizeNormal * textScale,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(pd.prize,
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeLarge * textScale,
                          ),
                          textAlign: TextAlign.end),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(pd.ticketWon,
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeLarge * textScale,
                          ),
                          textAlign: TextAlign.end),
                    )
                  ]))));
}
