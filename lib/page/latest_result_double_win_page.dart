import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_tw/component/prize_info_component.dart';
import 'package:lotto_tw/model/draw.dart';
import 'package:lotto_tw/model/prize_info.dart';

import '../api/prize_info_api.dart';
import '../component/lotto_num.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class LatestResultDoubleWinPage extends StatefulWidget {
  final Draw lotto;
  final String imgStr;
  const LatestResultDoubleWinPage(
      {super.key, required this.lotto, required this.imgStr});

  @override
  State<LatestResultDoubleWinPage> createState() =>
      _LatestResultDoubleWinState();
}

class _LatestResultDoubleWinState extends State<LatestResultDoubleWinPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late List<PrizeInfo>? prizeDataList = [];

  void _getPrizeData() async {
    prizeDataList = (await PrizeInfoApi.fetchPrizeInfoGet(
        widget.lotto.drawType, widget.lotto.drawNo))!;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => mounted ? setState(() {}) : {});
  }

  @override
  void initState() {
    _getPrizeData();
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenOffset = screenWidth < 450 ? 50 : 300;
    final double fontMultiplier = screenWidth < 450 ? 0.9 : 0.65;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    String drawType = widget.lotto.drawType;
    double fontSize = drawType != '7' ? 72 : AppConstants.fontSizeLarge;
    int flexNo1 = 4;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        pageHeader(context, screenWidth, textScale, 'latestResultTxt'.tr,
            iconButton: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                weight: 8,
                size: AppConstants.fontSizeLarge * 1.5 * textScale,
              ),
              onPressed: () => Navigator.pop(context, () {
                setState(() {});
              }),
            ),
            imgStr: widget.imgStr),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: _anchoredAdaptiveAd != null && _isLoaded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _anchoredAdaptiveAd!.size.width.toDouble(),
                      height: _anchoredAdaptiveAd!.size.height.toDouble(),
                      child: AdWidget(ad: _anchoredAdaptiveAd!),
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Image(width: 100, image: AssetImage(widget.imgStr)),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            lottoNum(widget.lotto.no1, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no2, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no3, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no4, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no5, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no6, textScale, fontSize, Colors.blue),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            lottoNum(widget.lotto.no7, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no8, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no9, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no10, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no11, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.no12, textScale, fontSize, Colors.blue),
          ],
        ),
        const SizedBox(height: 10),
        prizeDataList == null || prizeDataList!.isEmpty
            ? const CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: prizeDataList!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return prizeInfoComponent(
                          textScale, flexNo1, prizeDataList![i]);
                      //                         x.ticketWon);
                    }),
              ),
      ],
    )));
  }
}
