import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shake/shake.dart';

import '../component/lotto_num.dart';
import '../component/lotto_num_hit.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class LuckyDrawPage extends StatefulWidget {
  const LuckyDrawPage({super.key});

  @override
  State<LuckyDrawPage> createState() => _LuckyDrawPageState();
}

class _LuckyDrawPageState extends State<LuckyDrawPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  String drawType = '1';
  int numbers = 49;
  int drawNumber = 7;
  Color lottoMaxColor = Colors.white;
  Color lotto649Color = Colors.grey;
  Color kenoColor = Colors.grey;
  Color on49Color = Colors.grey;
  List<dynamic>? lists = [];
  List<dynamic>? lottoMaxLists = [];
  List<dynamic>? lotto649Lists = [];
  List<dynamic>? kenoLists = [];
  List<dynamic>? on49Lists = [];

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  @override
  void initState() {
    super.initState();
    _loadLatestLuckyNumbers();
  }

  @override
  void dispose() {
    super.dispose();
    _storeLatestLuckyNumbers();
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

  void _storeLatestLuckyNumbers() async {
    await storage.write(key: "lottoMaxLists", value: jsonEncode(lottoMaxLists));
    await storage.write(key: "lotto649Lists", value: jsonEncode(lotto649Lists));
    await storage.write(key: "kenoLists", value: jsonEncode(kenoLists));
    await storage.write(key: "on49Lists", value: jsonEncode(on49Lists));
  }

  void _loadLatestLuckyNumbers() async {
    String? histMaxLists = await storage.read(key: "lottoMaxLists");
    String? hist649Lists = await storage.read(key: "lotto649Lists");
    String? histKenoLists = await storage.read(key: "kenoLists");
    String? hist49Lists = await storage.read(key: "on49Lists");
    if (mounted) {
      setState(() {
        lottoMaxLists = histMaxLists != null ? jsonDecode(histMaxLists) : [];
        lotto649Lists = hist649Lists != null ? jsonDecode(hist649Lists) : [];
        kenoLists = histKenoLists != null ? jsonDecode(histKenoLists) : [];
        on49Lists = hist49Lists != null ? jsonDecode(hist49Lists) : [];
        lists = lottoMaxLists;
      });
    }
  }

  Future<void> changeDrawType(String inDrawType) async {
    setState(() {
      drawType = inDrawType;
      switch (inDrawType) {
        case '1':
          drawNumber = 7;
          numbers = 49;
          lists = lottoMaxLists!.reversed.toList();
          lottoMaxColor = Colors.white;
          lotto649Color = Colors.grey;
          kenoColor = Colors.grey;
          on49Color = Colors.grey;
          break;
        case '2':
          drawNumber = 6;
          numbers = 49;
          lists = lotto649Lists!.reversed.toList();
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.white;
          kenoColor = Colors.grey;
          on49Color = Colors.grey;
          break;
        case '3':
          drawNumber = 20;
          numbers = 70;
          lists = kenoLists!.reversed.toList();
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.grey;
          kenoColor = Colors.white;
          on49Color = Colors.grey;
          break;
        case '4':
          drawNumber = 6;
          numbers = 49;
          lists = on49Lists!.reversed.toList();
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.grey;
          kenoColor = Colors.grey;
          on49Color = Colors.white;
          break;
      }
    });
    _storeLatestLuckyNumbers();
  }

  void getNumbers(String drawType) {
    var rng = Random();
    int x = 0;
    List<int> tempList = [];
    do {
      int rn = rng.nextInt(numbers);
      if (rn == 0) continue;
      if (!tempList.contains(rn)) {
        tempList.add(rn);
        x++;
      }
    } while (x < drawNumber);

    tempList.sort();

    setState(() {
      switch (drawType) {
        case '1':
          lottoMaxLists!.add(tempList);
          lists = lottoMaxLists!.reversed.toList();
          break;
        case '2':
          lotto649Lists!.add(tempList);
          lists = lotto649Lists!.reversed.toList();
          break;
        case '3':
          kenoLists!.add(tempList);
          lists = kenoLists!.reversed.toList();
          break;
        case '4':
          on49Lists!.add(tempList);
          lists = on49Lists!.reversed.toList();
          break;
      }
    });
    _storeLatestLuckyNumbers();
  }

  void removeNumberFromList(int index) {
    setState(() {
      switch (drawType) {
        case '1':
          if (lists!.length > index) {
            lists!.remove(index);
            lottoMaxLists = lottoMaxLists!.reversed.toList();
            lottoMaxLists!.removeAt(index);
            lottoMaxLists = lottoMaxLists!.reversed.toList();
            lists = lottoMaxLists;
          }
          break;
        case '2':
          if (lists!.length > index) {
            lists!.remove(index);
            lotto649Lists = lotto649Lists!.reversed.toList();
            lotto649Lists!.removeAt(index);
            lotto649Lists = lotto649Lists!.reversed.toList();
            lists = lotto649Lists;
          }
          break;
        case '3':
          if (lists!.length > index) {
            lists!.remove(index);
            kenoLists = kenoLists!.reversed.toList();
            kenoLists!.removeAt(index);
            kenoLists = kenoLists!.reversed.toList();
            lists = kenoLists;
          }
          break;
        case '4':
          if (lists!.length > index) {
            lists!.remove(index);
            on49Lists = on49Lists!.reversed.toList();
            on49Lists!.removeAt(index);
            on49Lists = on49Lists!.reversed.toList();
            lists = on49Lists;
          }
          break;
      }
    });
    _storeLatestLuckyNumbers();
  }

  _buildVerticalItem(BuildContext context, int idx) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double fontMultiplier = screenWidth < 450 ? 1 : 0.65;
    fontMultiplier = screenWidth > 800 ? 0.55 : fontMultiplier;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    double fontSize = 160 * textScale;

    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: const Offset(0.0, 3.0),
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2.0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(height: 8),
          Row(
            children: [
              lottoNum(lists![idx][0].toString(), textScale, fontSize,
                  AppConstants.luckyDrawColor),
              const SizedBox(
                width: 2,
              ),
              lottoNum(lists![idx][1].toString(), textScale, fontSize,
                  AppConstants.luckyDrawColor),
              const SizedBox(
                width: 2,
              ),
              lottoNum(lists![idx][2].toString(), textScale, fontSize,
                  AppConstants.luckyDrawColor),
              const SizedBox(
                width: 2,
              ),
              lottoNum(lists![idx][3].toString(), textScale, fontSize,
                  AppConstants.luckyDrawColor),
              const SizedBox(
                width: 2,
              ),
              lottoNum(lists![idx][4].toString(), textScale, fontSize,
                  AppConstants.luckyDrawColor),
              const SizedBox(
                width: 2,
              ),
              drawNumber > 5
                  ? lottoNum(lists![idx][5].toString(), textScale, fontSize,
                      AppConstants.luckyDrawColor)
                  : Container(),
              const SizedBox(
                width: 2,
              ),
              drawNumber > 6
                  ? lottoNum(lists![idx][6].toString(), textScale, fontSize,
                      AppConstants.luckyDrawColor)
                  : Container(),
              const SizedBox(
                width: 2,
              ),
              drawNumber > 7
                  ? lottoNum(lists![idx][7].toString(), textScale, fontSize,
                      AppConstants.luckyDrawColor)
                  : Container(),
              const SizedBox(
                width: 2,
              ),
              drawNumber > 8
                  ? lottoNum(lists![idx][8].toString(), textScale, fontSize,
                      AppConstants.luckyDrawColor)
                  : Container(),
              const SizedBox(
                width: 2,
              ),
              drawNumber > 9
                  ? lottoNum(lists![idx][9].toString(), textScale, fontSize,
                      AppConstants.luckyDrawColor)
                  : Container(),
              const SizedBox(
                width: 2,
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  size: AppConstants.fontSizeLarge * 1.5 * textScale,
                ),
                onPressed: () {
                  removeNumberFromList(idx);
                },
              ),
            ],
          ),
          drawNumber > 10
              ? Row(
                  children: [
                    lottoNum(lists![idx][10].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][11].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][12].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][13].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][14].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][15].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][16].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][17].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][18].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                    lottoNum(lists![idx][19].toString(), textScale, fontSize,
                        AppConstants.luckyDrawColor),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenOffset = screenWidth < 450 ? 50 : 300;
    double fontMultiplier = screenWidth < 450 ? 1.1 : 0.65;
    fontMultiplier = screenWidth > 800 ? 0.55 : fontMultiplier;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    final double fontSize = 190 * textScale;
    final double imgScale = screenWidth < 450 ? 1.5 : 1.5;

    // ShakeDetector detector =
    ShakeDetector.autoStart(onPhoneShake: () {
      getNumbers(drawType);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(children: [
                pageHeader(context, screenWidth, textScale, 'luckyDrawTxt'.tr),
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
                              height:
                                  _anchoredAdaptiveAd!.size.height.toDouble(),
                              child: AdWidget(ad: _anchoredAdaptiveAd!),
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          changeDrawType('1');
                        },
                        child: Ink.image(
                          colorFilter: ColorFilter.mode(
                            lottoMaxColor,
                            BlendMode.modulate,
                          ),
                          width: 60 * imgScale,
                          height: 25 * imgScale,
                          image: const AssetImage(
                            "assets/image/max.png",
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          changeDrawType('2');
                        },
                        child: Ink.image(
                          colorFilter: ColorFilter.mode(
                            lotto649Color,
                            BlendMode.modulate,
                          ),
                          width: 60 * imgScale,
                          height: 25 * imgScale,
                          image: const AssetImage("assets/image/649.png"),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          changeDrawType('3');
                        },
                        child: Ink.image(
                          colorFilter: ColorFilter.mode(
                            kenoColor,
                            BlendMode.modulate,
                          ),
                          width: 60 * imgScale,
                          height: 25 * imgScale,
                          image:
                              const AssetImage("assets/image/daily-keno.png"),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          changeDrawType('4');
                        },
                        child: Ink.image(
                          colorFilter: ColorFilter.mode(
                            on49Color,
                            BlendMode.modulate,
                          ),
                          width: 72 * imgScale,
                          height: 36 * imgScale,
                          image: const AssetImage("assets/image/49.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Scrollbar(
                    child: GridView.count(
                      crossAxisCount: 10,
                      childAspectRatio: 0.8,
                      padding: const EdgeInsets.all(30),
                      children: List.generate(numbers, (index) {
                        int idx = index + 1;
                        bool isHit = false;
                        if (lists!.isNotEmpty && lists!.first.contains(idx)) {
                          isHit = true;
                        }
                        return lottoNumHit(
                            "$idx", textScale, fontSize, isHit, false);
                      }),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container())
              ]),
            ),
            Positioned.fill(
              child: SizedBox.expand(
                child: DraggableScrollableSheet(
                  minChildSize: 0.2,
                  maxChildSize: 0.8,
                  initialChildSize: 0.3,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 0.05 * getSize(context).height,
                        ),
                        height: 0.75 * getSize(context).height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              spreadRadius: 5.0,
                              offset: const Offset(0.0, 1.0),
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 0.025 * getSize(context).height),
                            Row(
                              children: [
                                const Spacer(),
                                Container(
                                  height: 4,
                                  width: 0.2 * getSize(context).width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            // SizedBox(height: 0.025 * getSize(context).height),
                            Center(
                              child: Text('latestLuckyNumber'.tr,
                                  style: TextStyle(
                                      fontSize: AppConstants.fontSizeNormal *
                                          textScale,
                                      fontWeight: FontWeight.w600)),
                            ),
                            lists!.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount: lists!.length,
                                      itemBuilder: (context, idx) =>
                                          _buildVerticalItem(context, idx),
                                      padding: EdgeInsets.all(
                                          AppConstants.marginNormal *
                                              textScale),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getNumbers(drawType);
        },
        label: Text(
          'drawShakeTxt'.tr,
          style: TextStyle(fontSize: AppConstants.fontSizeNormal * textScale),
        ),
        icon: Icon(
          Icons.circle_outlined,
          size: AppConstants.fontSizeNormal * textScale,
        ),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
