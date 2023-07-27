class CanadaLotto {
  final String id;
  final String name;
  final DateTime? date;
  final String drawDateType;
  final String bonus;
  final String guaranteed;
  final String encore;
  final String conditions;
  final String num1;
  final String num2;
  final String num3;
  final String num4;
  final String num5;
  final String num6;
  final String num7;
  final String num8;
  final String num9;
  final String num10;
  final String num11;
  final String num12;
  final String num13;
  final String num14;
  final String num15;
  final String num16;
  final String num17;
  final String num18;
  final String num19;
  final String num20;
  final DateTime? dateCr;
  final String drawType;

  CanadaLotto(
      {required this.id,
      required this.name,
      required this.date,
      required this.drawDateType,
      required this.bonus,
      required this.guaranteed,
      required this.encore,
      required this.conditions,
      required this.num1,
      required this.num2,
      required this.num3,
      required this.num4,
      required this.num5,
      required this.num6,
      required this.num7,
      required this.num8,
      required this.num9,
      required this.num10,
      required this.num11,
      required this.num12,
      required this.num13,
      required this.num14,
      required this.num15,
      required this.num16,
      required this.num17,
      required this.num18,
      required this.num19,
      required this.num20,
      required this.dateCr,
      required this.drawType});

  factory CanadaLotto.fromJson(Map<String, dynamic> json) => CanadaLotto(
        id: json['id'],
        name: json['name'],
        date: DateTime.tryParse(json['date']),
        drawDateType: json['draw_date_type'] ?? "",
        bonus: json['bonus'],
        guaranteed: json['guaranteed'],
        encore: json['encore'],
        conditions: json['conditions'],
        num1: json['num1'] ?? "",
        num2: json['num2'] ?? "",
        num3: json['num3'] ?? "",
        num4: json['num4'] ?? "",
        num5: json['num5'] ?? "",
        num6: json['num6'] ?? "",
        num7: json['num7'] ?? "",
        num8: json['num8'] ?? "",
        num9: json['num9'] ?? "",
        num10: json['num10'] ?? "",
        num11: json['num11'] ?? "",
        num12: json['num12'] ?? "",
        num13: json['num13'] ?? "",
        num14: json['num14'] ?? "",
        num15: json['num15'] ?? "",
        num16: json['num16'] ?? "",
        num17: json['num17'] ?? "",
        num18: json['num18'] ?? "",
        num19: json['num19'] ?? "",
        num20: json['num20'] ?? "",
        dateCr: DateTime.tryParse(json['date_cr']),
        drawType: json['draw_type'],
      );
}
