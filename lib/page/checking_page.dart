import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../component/lotto_num_check.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';
import 'check_results_page.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingState();
}

class _CheckingState extends State<CheckingPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  String drawType = '1';
  String imgStr = 'assets/image/lotto638.png';
  int numbers = 38;
  int drawNumber = 6;
  Color doubleWinColor = Colors.grey;
  Color lotto638Color = Colors.white;
  Color lotto649Color = Colors.grey;
  Color lotto539Color = Colors.grey;
  List<String> checkNumbers = [];
  List<String> checkNumbersDoubleWin = [];
  List<String> checkNumbersLotto638 = [];
  List<String> checkNumbersLotto649 = [];
  List<String> checkNumbersLotto539 = [];

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  @override
  void initState() {
    // _getData();
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

  Future<void> changeDrawType(String inDrawType) async {
    setState(() {
      drawType = inDrawType;
      switch (inDrawType) {
        case '1':
          imgStr = 'assets/image/lotto638.png';
          drawNumber = 6;
          numbers = 38;
          checkNumbers = checkNumbersLotto638;
          doubleWinColor = Colors.grey;
          lotto638Color = Colors.white;
          lotto649Color = Colors.grey;
          lotto539Color = Colors.grey;
          break;
        case '2':
          imgStr = 'assets/image/lotto649.jpg';
          drawNumber = 6;
          numbers = 49;
          checkNumbers = checkNumbersLotto649;
          doubleWinColor = Colors.grey;
          lotto638Color = Colors.grey;
          lotto649Color = Colors.white;
          lotto539Color = Colors.grey;
          break;
        case '3':
          imgStr = 'assets/image/lotto539.jpeg';
          drawNumber = 5;
          numbers = 39;
          checkNumbers = checkNumbersLotto539;
          doubleWinColor = Colors.grey;
          lotto638Color = Colors.grey;
          lotto649Color = Colors.grey;
          lotto539Color = Colors.white;
          break;
        case '7':
          imgStr = 'assets/image/doubleWin.png';
          drawNumber = 12;
          numbers = 24;
          checkNumbers = checkNumbersDoubleWin;
          doubleWinColor = Colors.white;
          lotto638Color = Colors.grey;
          lotto649Color = Colors.grey;
          lotto539Color = Colors.grey;
          break;
      }
    });
  }

  void addCheckNumbers(String drawType, String str) {
    switch (drawType) {
      case "1":
        setState(() {
          checkNumbersLotto638.add(str);
          checkNumbers = checkNumbersLotto638;
        });
        break;
      case "2":
        setState(() {
          checkNumbersLotto649.add(str);
          checkNumbers = checkNumbersLotto649;
        });
        break;
      case "3":
        setState(() {
          checkNumbersLotto539.add(str);
          checkNumbers = checkNumbersLotto539;
        });
        break;
      case "7":
        setState(() {
          checkNumbersDoubleWin.add(str);
          checkNumbers = checkNumbersDoubleWin;
        });
        break;
    }
  }

  void removeCheckNumbers(String drawType, String str) {
    switch (drawType) {
      case "1":
        setState(() {
          checkNumbersLotto638.remove(str);
          checkNumbers = checkNumbersLotto638;
        });
        break;
      case "2":
        setState(() {
          checkNumbersLotto649.remove(str);
          checkNumbers = checkNumbersLotto649;
        });
        break;
      case "3":
        setState(() {
          checkNumbersLotto539.remove(str);
          checkNumbers = checkNumbersLotto539;
        });
        break;
      case "7":
        setState(() {
          checkNumbersDoubleWin.remove(str);
          checkNumbers = checkNumbersDoubleWin;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double fontMultiplier = screenWidth < 450 ? 1 : 0.65;
    fontMultiplier = screenWidth > 800 ? 0.55 : fontMultiplier;
    final double textScale = screenWidth / 1200 * fontMultiplier;
    final double fontSize = 160 * textScale;
    final double imgScale = screenWidth > 800 ? 2 : 1.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          pageHeader(context, screenWidth, textScale, 'checkingTxt'.tr),
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
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    changeDrawType('7');
                  },
                  child: Ink.image(
                    colorFilter: ColorFilter.mode(
                      doubleWinColor,
                      BlendMode.modulate,
                    ),
                    width: 60 * imgScale,
                    height: 25 * imgScale,
                    image: const AssetImage(
                      "assets/image/doubleWin.png",
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    changeDrawType('1');
                  },
                  child: Ink.image(
                    colorFilter: ColorFilter.mode(
                      lotto638Color,
                      BlendMode.modulate,
                    ),
                    width: 60 * imgScale,
                    height: 25 * imgScale,
                    image: const AssetImage(
                      "assets/image/lotto638.png",
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
                    image: const AssetImage("assets/image/lotto649.jpg"),
                  ),
                ),
                InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    changeDrawType('3');
                  },
                  child: Ink.image(
                    colorFilter: ColorFilter.mode(
                      lotto539Color,
                      BlendMode.modulate,
                    ),
                    width: 60 * imgScale,
                    height: 25 * imgScale,
                    image: const AssetImage("assets/image/lotto539.jpeg"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 8,
              padding: const EdgeInsets.all(30),
              children: List.generate(numbers, (index) {
                int idx = index + 1;
                bool isHit = false;
                if (checkNumbers.contains("$idx")) {
                  isHit = true;
                }
                return LottoNumCheck(
                    str: "$idx",
                    isHit: isHit,
                    fontSize: fontSize,
                    textScale: textScale,
                    addChanged: (String sonStr) {
                      addCheckNumbers(drawType, sonStr);
                    },
                    removeChanged: (String sonStr) {
                      removeCheckNumbers(drawType, sonStr);
                    });
              }),
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckResultsPage(
                  drawType: drawType,
                  checkNumbers: checkNumbers,
                  imgStr: imgStr),
            ),
          );
        },
        label: Text(
          'checkingTxt'.tr,
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
