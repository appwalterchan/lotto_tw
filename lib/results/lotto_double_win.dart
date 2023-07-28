// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lotto_tw/api/draw_api.dart';

import '../component/lotto_num.dart';
import '../constant/app_constants.dart';
import '../model/draw.dart';
import '../page/history_result_double_win_page.dart';
import '../page/latest_result_double_win_page.dart';

class LottoDoubleWin extends StatefulWidget {
  final String imgStr;
  final String drawType;
  const LottoDoubleWin(
      {super.key, required this.imgStr, required this.drawType});

  @override
  State<LottoDoubleWin> createState() => _LottoDoubleWinState();
}

class _LottoDoubleWinState extends State<LottoDoubleWin> {
  late List<Draw>? lottoList = [];
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
    lottoList = (await DrawApi.fetchAllLottoListGet(widget.drawType))!;
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
    final double fontSize = 160 * textScale;

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
                                  image: AssetImage(widget.imgStr)),
                              Text(
                                lottoList![0].drawNo,
                                style: TextStyle(
                                    fontSize:
                                        AppConstants.fontSizeNormal * textScale,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(lottoList![0].drawDate!),
                                style: TextStyle(
                                    fontSize:
                                        AppConstants.fontSizeNormal * textScale,
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
                                lottoNum(lottoList![0].no1, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no2, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no3, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no4, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no5, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no6, textScale, fontSize,
                                    Colors.blue),
                              ],
                      ),
                      Row(
                        children: lottoList == null || lottoList!.isEmpty
                            ? [
                                const CircularProgressIndicator(),
                              ]
                            : [
                                lottoNum(lottoList![0].no7, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no8, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no9, textScale, fontSize,
                                    Colors.blue),
                                lottoNum(lottoList![0].no10, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].no11, textScale,
                                    fontSize, Colors.blue),
                                lottoNum(lottoList![0].no12, textScale,
                                    fontSize, Colors.blue),
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
                                    builder: (context) =>
                                        HistoryResultDoubleWinPage(
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
                                    builder: (context) =>
                                        LatestResultDoubleWinPage(
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
