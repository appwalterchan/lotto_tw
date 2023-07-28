class Draw {
  final String id;
  final String drawType;
  final String drawNo;
  final DateTime? drawDate;
  final String drawValidDate;
  final String no1;
  final String no2;
  final String no3;
  final String no4;
  final String no5;
  final String no6;
  final String no7;
  final String no8;
  final String no9;
  final DateTime? drawDateEn;
  final String drawDateCn;
  final String drawValidCn;
  final String prizeTotal;
  final String salesAmount;
  final String no10;
  final String no11;
  final String no12;
  final String no13;
  final String no14;
  final String no15;
  final String no16;
  final String no17;
  final String no18;
  final String no19;
  final String no20;
  final String bonus;
  final String bigorsmall;
  final String no21;
  final String no22;
  final String no23;
  final String no24;
  final String no25;
  final String no26;

  Draw({
    required this.id,
    required this.drawType,
    required this.drawNo,
    required this.drawDate,
    required this.drawValidDate,
    required this.no1,
    required this.no2,
    required this.no3,
    required this.no4,
    required this.no5,
    required this.no6,
    required this.no7,
    required this.no8,
    required this.no9,
    required this.drawDateEn,
    required this.drawDateCn,
    required this.drawValidCn,
    required this.prizeTotal,
    required this.salesAmount,
    required this.no10,
    required this.no11,
    required this.no12,
    required this.no13,
    required this.no14,
    required this.no15,
    required this.no16,
    required this.no17,
    required this.no18,
    required this.no19,
    required this.no20,
    required this.bonus,
    required this.bigorsmall,
    required this.no21,
    required this.no22,
    required this.no23,
    required this.no24,
    required this.no25,
    required this.no26,
  });

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
      id: json['id'] ?? "",
      drawType: json['draw_type'] ?? "",
      drawNo: json['draw_no'] ?? "",
      drawDate: DateTime.tryParse(json['draw_date']),
      drawValidDate: json['draw_valid_date'] ?? "",
      no1: json['no1'] ?? "",
      no2: json['no2'] ?? "",
      no3: json['no3'] ?? "",
      no4: json['no4'] ?? "",
      no5: json['no5'] ?? "",
      no6: json['no6'] ?? "",
      no7: json['no7'] ?? "",
      no8: json['no8'] ?? "",
      no9: json['no9'] ?? "",
      drawDateEn: DateTime.tryParse(json['draw_date_en']),
      drawDateCn: json['draw_date_cn'] ?? "",
      drawValidCn: json['draw_valid_cn'] ?? "",
      prizeTotal: json['prize_total'] ?? "",
      salesAmount: json['sales_amount'] ?? "",
      no10: json['no10'] ?? "",
      no11: json['no11'] ?? "",
      no12: json['no12'] ?? "",
      no13: json['no13'] ?? "",
      no14: json['no14'] ?? "",
      no15: json['no15'] ?? "",
      no16: json['no16'] ?? "",
      no17: json['no17'] ?? "",
      no18: json['no18'] ?? "",
      no19: json['no19'] ?? "",
      no20: json['no20'] ?? "",
      bonus: json['bonus'] ?? "",
      bigorsmall: json['bigorsmall'] ?? "",
      no21: json['no21'] ?? "",
      no22: json['no22'] ?? "",
      no23: json['no23'] ?? "",
      no24: json['no24'] ?? "",
      no25: json['no25'] ?? "",
      no26: json['no26'] ?? "");
}
