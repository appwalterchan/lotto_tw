class PrizeInfo {
  final String drawType;
  final String drawNo;
  final String prize;
  final String turnover;
  final String preAccum;
  final String prizeUnit;
  final String prizeAmount;
  final String prizeDesc;
  final int? seqNo;

  PrizeInfo(
      {required this.drawType,
      required this.drawNo,
      required this.prize,
      required this.turnover,
      required this.preAccum,
      required this.prizeUnit,
      required this.prizeAmount,
      required this.prizeDesc,
      required this.seqNo});

  factory PrizeInfo.fromJson(Map<String, dynamic> json) => PrizeInfo(
      drawType: json['draw_type'] ?? "",
      drawNo: json['draw_no'] ?? "",
      prize: json['prize'] ?? "",
      turnover: json['turnover'] ?? "",
      preAccum: json['pre_accum'] ?? "",
      prizeUnit: json['prize_unit'] ?? "",
      prizeAmount: json['prize_amount'] ?? "",
      prizeDesc: json['prize_desc'] ?? "",
      seqNo: int.tryParse(json['seq_no'] ?? ""));
}
