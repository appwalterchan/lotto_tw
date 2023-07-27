import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_cad/model/canada_lotto.dart';
import 'package:lotto_cad/model/prize_data.dart';

import '../api/prize_data_api.dart';
import '../component/lotto_num.dart';
import '../component/lotto_prize.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class LatestResultKenoPage extends StatefulWidget {
  final CanadaLotto lotto;
  final String imgStr;
  const LatestResultKenoPage(
      {super.key, required this.lotto, required this.imgStr});

  @override
  State<LatestResultKenoPage> createState() => _LatestResultKenoPageState();
}

class _LatestResultKenoPageState extends State<LatestResultKenoPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late List<PrizeData>? prizeDataList = [];

  void _getPrizeData() async {
    prizeDataList = (await PrizeDataApi.fetchPrizeDataGet(
        widget.lotto.drawType, widget.lotto.date))!;
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
            lottoNum(widget.lotto.num1, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num2, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num3, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num4, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num5, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num6, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num7, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num8, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num9, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num10, textScale, fontSize, Colors.blue),
            SizedBox(
              width: fontSize / 4,
            ),
            lottoNum(widget.lotto.bonus, textScale, fontSize, Colors.red),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            lottoNum(widget.lotto.num11, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num12, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num13, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num14, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num15, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num16, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num17, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num18, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num19, textScale, fontSize, Colors.blue),
            lottoNum(widget.lotto.num20, textScale, fontSize, Colors.blue),
            SizedBox(
              width: fontSize / 4,
            ),
            lottoNum(widget.lotto.bonus, textScale, fontSize, Colors.red),
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
                      return lottoPrize(textScale, flexNo1, prizeDataList![i]);
                      //                         x.ticketWon);
                    }),
              ),
      ],
    )));
  }
}
