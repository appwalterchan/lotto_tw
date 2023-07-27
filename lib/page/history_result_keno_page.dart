import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lotto_tw/component/history_result_keno_check.dart';
import 'package:lotto_tw/model/canada_lotto.dart';

import '../component/page_header.dart';
import '../constant/app_constants.dart';

class HistoryResultKenoPage extends StatefulWidget {
  final List<CanadaLotto>? lottoList;
  final String imgStr;
  const HistoryResultKenoPage(
      {super.key, required this.lottoList, required this.imgStr});

  @override
  State<HistoryResultKenoPage> createState() => _HistoryResultKenoState();
}

class _HistoryResultKenoState extends State<HistoryResultKenoPage> {
  final _kAdIndex = 10;

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      debugPrint('Unable to get height of anchored banner.');
      return;
    }

    final AdSize adSize = size.width > 450
        ? AdSize(
            width: (size.width * 0.65).round(),
            height: (size.height * 0.65).round())
        : AdSize(width: (size.width), height: (size.height));

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: AppConstants.bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _anchoredAdaptiveAd != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenOffset = screenWidth < 450 ? 50 : 300;
    final double fontMultipler = screenWidth < 450 ? 1.1 : 0.65;
    final double textScale = screenWidth / 1200 * fontMultipler;
    // final double fontSize = 190 * textScale;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            pageHeader(context, screenWidth, textScale, 'historyResultTxt'.tr,
                iconButton: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    weight: 8,
                    size: AppConstants.fontSizeLarge * 1.5 * textScale,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                imgStr: widget.imgStr),
            Image(width: 260 * textScale, image: AssetImage(widget.imgStr)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.lottoList!.length +
                    (_anchoredAdaptiveAd != null ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_anchoredAdaptiveAd != null &&
                      _isLoaded &&
                      index == _kAdIndex) {
                    return Container(
                      width: _anchoredAdaptiveAd!.size.width.toDouble(),
                      height: _anchoredAdaptiveAd!.size.height.toDouble(),
                      alignment: Alignment.center,
                      child: AdWidget(ad: _anchoredAdaptiveAd!),
                    );
                  } else {
                    final item =
                        widget.lottoList![_getDestinationItemIndex(index)];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide())),
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd').format(item.date!),
                                  style: TextStyle(
                                      fontSize: AppConstants.fontSizeLarge *
                                          0.75 *
                                          textScale,
                                      fontWeight: FontWeight.bold),
                                ),
                                item.drawDateType.isNotEmpty
                                    ? Text(
                                        item.drawDateType,
                                        style: TextStyle(
                                          fontSize: AppConstants.fontSizeSmall *
                                              0.75 *
                                              textScale,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            historyResultKenoCheck(item, textScale, []),
                          ]),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
