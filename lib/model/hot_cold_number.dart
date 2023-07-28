class HotColdNumber {
  final String drawType;
  final String numbers;
  final int? total;

  HotColdNumber(
      {required this.drawType, required this.numbers, required this.total});

  factory HotColdNumber.fromJson(Map<String, dynamic> json) => HotColdNumber(
      drawType: json['draw_type'],
      numbers: json['numbers'],
      total: int.tryParse(json['total']));
}
