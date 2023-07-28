import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lotto_tw/model/draw.dart';

import '../api/draw_api.dart';
import '../component/history_result_34_check.dart';
import '../component/history_result_check.dart';
import '../component/history_result_double_win_check copy.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class CheckResultsPage extends StatefulWidget {
  final String drawType;
  final List<String> checkNumbers;
  final String imgStr;
  const CheckResultsPage(
      {super.key,
      required this.drawType,
      required this.checkNumbers,
      required this.imgStr});

  @override
  State<CheckResultsPage> createState() => _CheckResultsState();
}

class _CheckResultsState extends State<CheckResultsPage> {
  final _kAdIndex = 10;

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  late List<Draw>? apiLottoList = [];

  @override
  void initState() {
    _getData();
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

  void _getData() async {
    apiLottoList = (await DrawApi.fetchAllLottoListGet(widget.drawType))!;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => mounted ? setState(() {}) : {});
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
    final double fontMultiplier = screenWidth < 450 ? 1.1 : 0.65;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    // final double fontSize = 190 * textScale;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            pageHeader(context, screenWidth, textScale, 'checkResults'.tr,
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
            apiLottoList == null || apiLottoList!.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: apiLottoList!.length +
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
                              apiLottoList![_getDestinationItemIndex(index)];

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: const BoxDecoration(
                                border: Border(top: BorderSide())),
                            child: Row(children: [
                              Text(
                                DateFormat('yyyy-MM-dd').format(item.drawDate!),
                                style: TextStyle(
                                    fontSize: AppConstants.fontSizeLarge *
                                        0.75 *
                                        textScale,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              widget.drawType == '7'
                                  ? historyResultDoubleWinCheck(
                                      item, textScale, widget.checkNumbers)
                                  : widget.drawType == '4'
                                      ? historyResult34Check(
                                          item, textScale, widget.checkNumbers)
                                      : historyResultCheck(
                                          item, textScale, widget.checkNumbers),
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
