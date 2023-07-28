import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_tw/model/draw.dart';

import '../component/lotto_34_hist.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class HistoryResult34Page extends StatefulWidget {
  final List<Draw>? lottoList;
  final String imgStr3;
  final String imgStr4;
  const HistoryResult34Page(
      {super.key,
      required this.lottoList,
      required this.imgStr3,
      required this.imgStr4});

  @override
  State<HistoryResult34Page> createState() => _HistoryResult34State();
}

class _HistoryResult34State extends State<HistoryResult34Page> {
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
    double fontMultiplier = screenWidth < 450 ? 1.1 : 0.65;
    fontMultiplier = screenWidth > 800 ? 0.55 : fontMultiplier;
    final double textScale = screenWidth / 1200 * fontMultiplier;
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
                imgStr: null),
            // Image(width: 260 * textScale, image: AssetImage(widget.imgStr)),
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

                      return Lotto34Hist(
                        imgStr3: widget.imgStr3,
                        imgStr4: widget.imgStr4,
                        lotto: item,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
