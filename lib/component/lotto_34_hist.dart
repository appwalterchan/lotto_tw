// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../constant/app_constants.dart';
import '../model/draw.dart';
import 'lotto_num.dart';

class Lotto34Hist extends StatefulWidget {
  final String imgStr3;
  final String imgStr4;
  final Draw lotto;
  const Lotto34Hist(
      {super.key,
      required this.imgStr3,
      required this.imgStr4,
      required this.lotto});

  @override
  State<Lotto34Hist> createState() => _Lotto34HistState();
}

class _Lotto34HistState extends State<Lotto34Hist> {
  InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenOffset = screenWidth < 450 ? 50 : 300;
    double fontMultiplier = screenWidth < 450 ? 1.1 : 0.65;
    fontMultiplier = screenWidth > 800 ? 0.55 : fontMultiplier;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    final double fontSize = 190 * textScale;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        // width: screenWidth - 50,
        color: Colors.white,
        // alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
            vertical: 4, horizontal: AppConstants.marginNormal),
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: AppConstants.marginNormal),
                width: screenWidth - screenOffset,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        width: 220 * textScale,
                        image: AssetImage(widget.imgStr3),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.lotto.drawNo,
                            style: TextStyle(
                                fontSize:
                                    AppConstants.fontSizeNormal * textScale,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(widget.lotto.drawDate!),
                            style: TextStyle(
                                fontSize:
                                    AppConstants.fontSizeNormal * textScale,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Image(
                        width: 220 * textScale,
                        image: AssetImage(widget.imgStr4),
                      ),
                    ]),
              ),
              Row(
                children: [
                  lottoNum(widget.lotto.no5, textScale, fontSize, Colors.blue),
                  lottoNum(widget.lotto.no6, textScale, fontSize, Colors.blue),
                  lottoNum(widget.lotto.no7, textScale, fontSize, Colors.blue),
                  const SizedBox(
                    width: 30,
                  ),
                  lottoNum(widget.lotto.no1, textScale, fontSize, Colors.blue),
                  lottoNum(widget.lotto.no2, textScale, fontSize, Colors.blue),
                  lottoNum(widget.lotto.no3, textScale, fontSize, Colors.blue),
                  lottoNum(widget.lotto.no4, textScale, fontSize, Colors.blue),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}
