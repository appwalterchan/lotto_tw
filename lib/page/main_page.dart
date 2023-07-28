import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_tw/constant/locale_string.dart';
import 'package:lotto_tw/page/checking_page.dart';
import 'package:lotto_tw/page/statistic_page.dart';

import '../constant/app_constants.dart';
import 'all_result_page.dart';
import 'lucky_draw_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedIndex = 0;
  InterstitialAd? interstitialAd;

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  @override
  void initState() {
    _loadLocale();
    super.initState();
  }

  void _loadLocale() async {
    String? countryCode = await storage.read(key: "countryCode");
    LocaleString.updateLocaleByCountryCode(countryCode);
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
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const AllResultsPage();
        break;
      case 1:
        page = const LuckyDrawPage();
        break;
      case 2:
        page = const StatisticPage();
        break;
      case 3:
        page = const CheckingPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.background,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: 'allResultsTxt'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.favorite),
                        label: 'luckyDrawTxt'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.add_chart),
                        label: 'statisticTxt'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.check),
                        label: 'checkingTxt'.tr,
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                        if (Random().nextInt(AppConstants.interAdFrequency) ==
                            1) {
                          loadInterstitialAd();
                          interstitialAd?.show();
                        }
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: const Icon(Icons.home),
                        label: Text('allResultsTxt'.tr),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.favorite),
                        label: Text('luckyDrawTxt'.tr),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.add_chart),
                        label: Text('statisticTxt'.tr),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.check),
                        label: Text('checkingTxt'.tr),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                        if (Random().nextInt(AppConstants.interAdFrequency) ==
                            1) {
                          loadInterstitialAd();
                          interstitialAd?.show();
                        }
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
