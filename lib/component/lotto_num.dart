import 'package:flutter/material.dart';

Container lottoNum(
    String str, double textScale, double fontSize, Color backgroundColor) {
  return str.isNotEmpty
      ? Container(
          alignment: Alignment.center,
          width: fontSize * textScale * 1.5,
          height: fontSize * textScale * 1.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          margin: EdgeInsets.all(4 * textScale),
          // padding: const EdgeInsets.all(2),
          child: Center(
            child: Text(str,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize * textScale,
                    color: Colors.white)),
          ),
        )
      : Container(
          child: null,
        );
}
