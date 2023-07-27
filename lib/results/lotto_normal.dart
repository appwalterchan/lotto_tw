// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lotto_cad/api/canada_lotto_api.dart';
import 'package:lotto_cad/page/history_result_page.dart';
import 'package:lotto_cad/page/latest_result_page.dart';

import '../component/lotto_num.dart';
import '../constant/app_constants.dart';
import '../model/canada_lotto.dart';

class LottoNormal extends StatefulWidget {
  final String imgStr;
  final String drawType;
  const LottoNormal({super.key, required this.imgStr, required this.drawType});

  @override
  State<LottoNormal> createState() => _LottoNormalState();
}

class _LottoNormalState extends State<LottoNormal> {
  late List<CanadaLotto>? lottoList = [];
  InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    _getData();
    loadInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getData() async {
    lottoList = (await CanadaLottoApi.fetchCanadaLottoGet(widget.drawType))!;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => mounted ? setState(() {}) : {});
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AppConstants.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
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
            Column(
              children: lottoList == null || lottoList!.isEmpty
                  ? [
                      const CircularProgressIndicator(),
                    ]
                  : [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: AppConstants.marginLarge * textScale),
                        width: screenWidth - screenOffset,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                width: 220 * textScale,
                                image: AssetImage(widget.imgStr),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(lottoList![0].date!),
                                style: TextStyle(
                                    fontSize:
                                        AppConstants.fontSizeLarge * textScale,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            ]),
                      ),
                      Row(
                        children: lottoList == null || lottoList!.isEmpty
                            ? [
                                const CircularProgressIndicator(),
                              ]
                            : [
                                lottoNum(lottoList![0].num1, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num2, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num3, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num4, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num5, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num6, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].num7, textScale,
                                    fontSize, Colors.blue),
                                const SizedBox(
                                  width: 10,
                                ),
                                lottoNum(lottoList![0].bonus, textScale,
                                    fontSize, Colors.red),
                              ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: AppConstants.marginLarge * textScale),
                        width: screenWidth - screenOffset,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppConstants.marginNormal *
                                          textScale),
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      AppConstants.latestResultColor,
                                  textStyle: TextStyle(
                                      fontSize: AppConstants.fontSizeNormal *
                                          textScale,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HistoryResultPage(
                                        lottoList: lottoList,
                                        imgStr: widget.imgStr),
                                  ),
                                );
                              },
                              child: Text('historyResultTxt'.tr),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppConstants.marginNormal *
                                          textScale),
                                  foregroundColor: Colors.white,
                                  backgroundColor: AppConstants.historyColor,
                                  textStyle: TextStyle(
                                      fontSize: AppConstants.fontSizeNormal *
                                          textScale,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LatestResultPage(
                                        lotto: lottoList![0],
                                        imgStr: widget.imgStr),
                                  ),
                                );
                              },
                              child: Text('latestResultTxt'.tr),
                            ),
                          ],
                        ),
                      )
                    ],
            )
          ],
        ),
      ),
    );
  }
}
