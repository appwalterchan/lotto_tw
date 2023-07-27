import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lotto_cad/page/check_results_page.dart';

import '../component/lotto_num_check.dart';
import '../component/page_header.dart';
import '../constant/app_constants.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingState();
}

class _CheckingState extends State<CheckingPage> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  String drawType = '1';
  String imgStr = 'assets/image/max.png';
  int numbers = 49;
  int drawNumber = 7;
  Color lottoMaxColor = Colors.white;
  Color lotto649Color = Colors.grey;
  Color kenoColor = Colors.grey;
  Color on49Color = Colors.grey;
  // late List<CanadaLotto>? apiLottoMaxList = [];
  // late List<CanadaLotto>? apiLotto649List = [];
  // late List<CanadaLotto>? apiKenoList = [];
  // late List<CanadaLotto>? apiOn49List = [];
  // late List<CanadaLotto>? apiLottoNumList = [];
  List<String> checkNumbers = [];
  List<String> checkNumbersLottoMax = [];
  List<String> checkNumbersLotto649 = [];
  List<String> checkNumbersKeno = [];
  List<String> checkNumbersOn49 = [];

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

  // void _getData() async {
  //   apiLottoMaxList = (await CanadaLottoApi.fetchCanadaLottoGet('1'))!;
  //   apiLotto649List = (await CanadaLottoApi.fetchCanadaLottoGet('2'))!;
  //   apiKenoList = (await CanadaLottoApi.fetchCanadaLottoGet('3'))!;
  //   apiOn49List = (await CanadaLottoApi.fetchCanadaLottoGet('4'))!;
  //   setState(() {
  //     apiLottoNumList = apiLottoMaxList;
  //   });
  //   Future.delayed(const Duration(milliseconds: 200))
  //       .then((value) => mounted ? setState(() {}) : {});
  // }

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
          imgStr = 'assets/image/max.png';
          drawNumber = 7;
          numbers = 49;
          // apiLottoNumList = apiLottoMaxList;
          checkNumbers = checkNumbersLottoMax;
          lottoMaxColor = Colors.white;
          lotto649Color = Colors.grey;
          kenoColor = Colors.grey;
          on49Color = Colors.grey;
          break;
        case '2':
          imgStr = 'assets/image/649.png';
          drawNumber = 6;
          numbers = 49;
          // apiLottoNumList = apiLotto649List;
          checkNumbers = checkNumbersLotto649;
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.white;
          kenoColor = Colors.grey;
          on49Color = Colors.grey;
          break;
        case '3':
          imgStr = 'assets/image/daily-keno.png';
          drawNumber = 20;
          numbers = 70;
          // apiLottoNumList = apiKenoList;
          checkNumbers = checkNumbersKeno;
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.grey;
          kenoColor = Colors.white;
          on49Color = Colors.grey;
          break;
        case '4':
          imgStr = 'assets/image/49.png';
          drawNumber = 6;
          numbers = 49;
          // apiLottoNumList = apiOn49List;
          checkNumbers = checkNumbersOn49;
          lottoMaxColor = Colors.grey;
          lotto649Color = Colors.grey;
          kenoColor = Colors.grey;
          on49Color = Colors.white;
          break;
      }
    });
  }

  void addCheckNumbers(String drawType, String str) {
    switch (drawType) {
      case "1":
        setState(() {
          checkNumbersLottoMax.add(str);
          checkNumbers = checkNumbersLottoMax;
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
          checkNumbersKeno.add(str);
          checkNumbers = checkNumbersKeno;
        });
        break;
      case "4":
        setState(() {
          checkNumbersOn49.add(str);
          checkNumbers = checkNumbersOn49;
        });
        break;
    }
  }

  void removeCheckNumbers(String drawType, String str) {
    switch (drawType) {
      case "1":
        setState(() {
          checkNumbersLottoMax.remove(str);
          checkNumbers = checkNumbersLottoMax;
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
          checkNumbersKeno.remove(str);
          checkNumbers = checkNumbersKeno;
        });
        break;
      case "4":
        setState(() {
          checkNumbersOn49.remove(str);
          checkNumbers = checkNumbersOn49;
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
                    image: const AssetImage("assets/image/daily-keno.png"),
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
                  // lottoList: apiLottoNumList,
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
