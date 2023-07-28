import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

// https://protocoderspoint.com/flutter-change-app-language-flutter-getx-localization/
class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'allResultsTxt': "All Result",
          'luckyDrawTxt': "Lucky Draw",
          'checkingTxt': "Checking",
          'checkResults': "Check Results",
          'drawShakeTxt': "Shake or Draw",
          'latestResultTxt': "Latest",
          'historyResultTxt': "History",
          'latestLuckyNumber': "Latest Lucky Number",
          'statisticTxt': "Statistic",
          'coldNumbers': "Rare Numbers",
          'hotNumbers': "Hot Numbers",
        },
        'zh_TW': {
          'allResultsTxt': "全部結果",
          'luckyDrawTxt': "幸運號碼",
          'checkingTxt': "核對號碼",
          'checkResults': "核對結果",
          'drawShakeTxt': "搖或抽",
          'latestResultTxt': "最新結果",
          'historyResultTxt': "歷史結果",
          'latestLuckyNumber': "最新幸運號碼",
          'statisticTxt': "統計",
          'coldNumbers': "冷門號碼",
          'hotNumbers': "熱門號碼",
        },
        'zh_CN': {
          'allResultsTxt': "全部结果",
          'luckyDrawTxt': "幸运号码",
          'checkingTxt': "核对号码",
          'checkResults': "核对结果",
          'drawShakeTxt': "摇或抽",
          'latestResultTxt': "最新结果",
          'historyResultTxt': "历史结果",
          'latestLuckyNumber': "最新幸运号码",
          'statisticTxt': "统计",
          'coldNumbers': "冷门号码",
          'hotNumbers': "热门号码",
        },
      };

  static List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': '繁體中文', 'locale': const Locale('zh', 'TW')},
    {'name': '簡体中文', 'locale': const Locale('zh', 'CN')},
  ];

  static updateLocaleByCountryCode(String? countryCode) {
    if (countryCode == null) return;
    switch (countryCode) {
      case "US":
        Get.updateLocale(const Locale('en', 'US'));
        break;
      case "TW":
        Get.updateLocale(const Locale('zh', 'TW'));
        break;
      case "CN":
        Get.updateLocale(const Locale('zh', 'CN'));
        break;
    }
  }

  static updateLanguage(Locale locale) async {
    Get.back();
    Get.updateLocale(locale);
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    debugPrint("update Language ${locale.countryCode}");
    await storage.write(key: "countryCode", value: locale.countryCode);
  }

  static buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(LocaleString.locale[index]['name']),
                        onTap: () {
                          // debugPrint(LocaleString.locale[index]['name']);
                          LocaleString.updateLanguage(
                              LocaleString.locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: LocaleString.locale.length),
            ),
          );
        });
  }
}
