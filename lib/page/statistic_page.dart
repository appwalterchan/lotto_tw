import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_tw/api/hot_cold_number_api.dart';
import 'package:lotto_tw/model/hot_cold_number.dart';

import '../component/lotto_num.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({
    super.key,
  });

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late List<HotColdNumber>? hcNumDoubleWin = [];
  late List<HotColdNumber>? hcNumLotto638 = [];
  late List<HotColdNumber>? hcNumLotto649 = [];
  late List<HotColdNumber>? hcNumLotto539 = [];

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
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

  void getData() async {
    hcNumDoubleWin = (await HotColdNumberApi.fetchHotColdNumberGet("7"))!;
    hcNumLotto638 = (await HotColdNumberApi.fetchHotColdNumberGet("1"))!;
    hcNumLotto649 = (await HotColdNumberApi.fetchHotColdNumberGet("2"))!;
    hcNumLotto539 = (await HotColdNumberApi.fetchHotColdNumberGet("3"))!;
    if (mounted) {
      Future.delayed(const Duration(milliseconds: 200))
          .then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenOffset = screenWidth < 450 ? 50 : 300;
    double fontMultipler = screenWidth < 450 ? 1.1 : 0.65;
    fontMultipler = screenWidth > 800 ? 0.55 : fontMultipler;
    final double textScale = screenWidth / 1200 * fontMultipler;
    final double fontSize = 180 * textScale;

    const double sizeBoxHeight = 8;
    const Color dividerColor = Colors.lightGreen;
    const Color hotColor = Colors.blue;
    const Color coldColor = Colors.green;

    var children2 = [
      Column(children: [
        ListTile(
          leading: const Image(
              width: 62, image: AssetImage("assets/image/doubleWin.png")),
          title: Text(
            'hotNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumDoubleWin == null || hcNumDoubleWin!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(hcNumDoubleWin![0], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![1], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![2], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![3], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![4], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![5], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![6], textScale, fontSize, hotColor),
                  showHitNum(hcNumDoubleWin![7], textScale, fontSize, hotColor),
                ],
        ),
        ListTile(
          leading: const Image(
              width: 62, image: AssetImage("assets/image/doubleWin.png")),
          title: Text(
            'coldNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumDoubleWin == null || hcNumDoubleWin!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(
                      hcNumDoubleWin![23], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![22], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![21], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![20], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![19], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![18], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![17], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumDoubleWin![16], textScale, fontSize, coldColor),
                ],
        ),
        const SizedBox(
          height: sizeBoxHeight,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: dividerColor,
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        ListTile(
          leading: const Image(
              width: 58, image: AssetImage("assets/image/lotto638.png")),
          title: Text(
            'hotNumbers'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto638 == null || hcNumLotto638!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(hcNumLotto638![0], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![1], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![2], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![3], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![4], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![5], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![6], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto638![7], textScale, fontSize, hotColor),
                ],
        ),
        ListTile(
          leading: const Image(
              width: 58, image: AssetImage("assets/image/lotto638.png")),
          title: Text(
            'coldNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto638 == null || hcNumLotto638!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(
                      hcNumLotto638![37], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![36], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![35], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![34], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![33], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![32], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![31], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto638![30], textScale, fontSize, coldColor),
                ],
        ),
        const SizedBox(
          height: sizeBoxHeight,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: dividerColor,
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        ListTile(
          leading: const Image(
              width: 60, image: AssetImage("assets/image/lotto649.jpg")),
          title: Text(
            'hotNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto649 == null || hcNumLotto649!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(hcNumLotto649![0], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![1], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![2], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![3], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![4], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![5], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![6], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto649![7], textScale, fontSize, hotColor),
                ],
        ),
        ListTile(
          leading: const Image(
              width: 60, image: AssetImage("assets/image/lotto649.jpg")),
          title: Text(
            'coldNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto649 == null || hcNumLotto649!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(
                      hcNumLotto649![48], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![47], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![46], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![45], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![44], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![43], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![42], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto649![41], textScale, fontSize, coldColor),
                ],
        ),
        const SizedBox(
          height: sizeBoxHeight,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: dividerColor,
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        ListTile(
          leading: const Image(
              width: 58, image: AssetImage("assets/image/lotto539.jpeg")),
          title: Text(
            'hotNumbers'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto539 == null || hcNumLotto539!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(hcNumLotto539![0], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![1], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![2], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![3], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![4], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![5], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![6], textScale, fontSize, hotColor),
                  showHitNum(hcNumLotto539![7], textScale, fontSize, hotColor),
                ],
        ),
        ListTile(
          leading: const Image(
              width: 58, image: AssetImage("assets/image/lotto539.jpeg")),
          title: Text(
            'coldNumbers'.tr,
            style: TextStyle(
                fontSize: AppConstants.fontSizeLarge * textScale,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: sizeBoxHeight - 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: hcNumLotto539 == null || hcNumLotto539!.isEmpty
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  showHitNum(
                      hcNumLotto539![38], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![37], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![36], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![35], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![34], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![33], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![32], textScale, fontSize, coldColor),
                  showHitNum(
                      hcNumLotto539![31], textScale, fontSize, coldColor),
                ],
        ),
        const SizedBox(
          height: sizeBoxHeight,
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: dividerColor,
        ),
      ]),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            pageHeader(context, screenWidth, textScale, 'statisticTxt'.tr),
            const SizedBox(
              height: 2,
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
              height: 2,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.marginLarge * textScale),
                children: children2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  badges.Badge showHitNum(
      HotColdNumber hitNum, double textScale, double fontSize, Color color) {
    return badges.Badge(
      badgeContent: Text(
        hitNum.total.toString(),
        style: TextStyle(fontSize: AppConstants.fontSizeSmall * textScale),
      ),
      position: badges.BadgePosition.topEnd(top: -12, end: -16),
      badgeStyle: const badges.BadgeStyle(badgeColor: Colors.orangeAccent),
      child: lottoNum(hitNum.numbers.toString(), textScale, fontSize, color),
    );
  }
}
