import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../component/page_header.dart';
import '../constant/app_constants.dart';
import '../results/lotto_keno.dart';
import '../results/lotto_normal.dart';

class AllResultsPage extends StatefulWidget {
  const AllResultsPage({super.key});

  @override
  State<AllResultsPage> createState() => _AllResultsPageState();
}

class _AllResultsPageState extends State<AllResultsPage> {
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenOffset = screenWidth < 450 ? 50 : 300;
    final double fontMultipler = screenWidth < 450 ? 1.1 : 0.65;
    final double textScale = screenWidth / 1200 * fontMultipler;
    // final double fontSize = 190 * textScale;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              pageHeader(context, screenWidth, textScale, 'allResultsTxt'.tr),
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
              const LottoNormal(
                imgStr: 'assets/image/max.png',
                drawType: '1',
              ),
              const LottoNormal(
                imgStr: 'assets/image/649.png',
                drawType: '2',
              ),
              const LottoKeno(
                imgStr: 'assets/image/daily-keno.png',
                drawType: '3',
              ),
              const LottoNormal(
                imgStr: 'assets/image/49.png',
                drawType: '4',
              ),
              const LottoNormal(
                imgStr: 'assets/image/pick4.png',
                drawType: '5',
              ),
              const LottoNormal(
                imgStr: 'assets/image/pick3.png',
                drawType: '6',
              ),
              const LottoNormal(
                imgStr: 'assets/image/pick2.png',
                drawType: '7',
              ),
            ],
          ),
        ),
      )),
    );
  }
}
