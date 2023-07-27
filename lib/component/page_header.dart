import 'package:flutter/material.dart';

import '../constant/app_constants.dart';
import '../constant/locale_string.dart';

Widget pageHeader(
    BuildContext context, double screenWidth, double textScale, String txt,
    {IconButton? iconButton, String? imgStr}) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(
        vertical: AppConstants.marginSmall,
        horizontal: AppConstants.marginNormal),
    child: AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppConstants.marginNormal),
            bottomRight: Radius.circular(AppConstants.marginNormal)),
      ),
      title: Text(
        txt,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppConstants.fontSizeLarge * textScale,
            color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
          child: IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              LocaleString.buildLanguageDialog(context);
            },
          ),
        ),
      ],
    ),
  );
}
