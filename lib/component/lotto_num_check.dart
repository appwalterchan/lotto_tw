import 'package:flutter/material.dart';

typedef StringCallback = void Function(String str);

// ignore: must_be_immutable
class LottoNumCheck extends StatefulWidget {
  final String str;
  final bool isHit;
  final double fontSize;
  final double textScale;
  final StringCallback addChanged;
  final StringCallback removeChanged;
  const LottoNumCheck({
    super.key,
    required this.str,
    required this.isHit,
    required this.fontSize,
    required this.textScale,
    required this.addChanged,
    required this.removeChanged,
  });

  @override
  State<LottoNumCheck> createState() => _LottoNumCheckState();
}

class _LottoNumCheckState extends State<LottoNumCheck> {
  late bool isHit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isHit = widget.isHit;
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHit ? Colors.orange : Colors.grey[400],
        ),
        margin: const EdgeInsets.all(2),
        child: TextButton(
          child: Text(widget.str,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize * widget.textScale,
                  color: Colors.white)),
          onPressed: () {
            setState(() {
              isHit = !isHit;
            });
            isHit
                ? widget.addChanged(widget.str)
                : widget.removeChanged(widget.str);
          },
        ));
  }
}
