import 'package:flutter/material.dart';

Container lottoNumHit(String str, double textScale, double fontSize, bool isHit,
    bool isSpecialNum) {
  Color? normalColor = isSpecialNum ? Colors.red : Colors.blue[200];
  return str.isNotEmpty
      ? Container(
          alignment: Alignment.center,
          width: fontSize * textScale * 1.5,
          height: fontSize * textScale * 1.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isHit ? Colors.orange : normalColor,
          ),
          margin: EdgeInsets.all(4 * textScale),
          child: Text(
            str,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSize * textScale,
                color: Colors.white),
          ),
        )
      : Container();
}
