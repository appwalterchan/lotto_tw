class PrizeData {
  final String id;
  final String name;
  final DateTime? drawDate;
  final String drawDateType;
  final int? matchSeq;
  final String match;
  final String ticketWon;
  final String prize;
  final String drawType;

  PrizeData(
      {required this.id,
      required this.name,
      required this.drawDate,
      required this.drawDateType,
      required this.matchSeq,
      required this.match,
      required this.ticketWon,
      required this.prize,
      required this.drawType});

  factory PrizeData.fromJson(Map<String, dynamic> json) => PrizeData(
      id: json['id'],
      name: json['name'],
      drawDate: DateTime.tryParse(json['draw_date']),
      drawDateType: json['draw_date_type'],
      matchSeq: int.tryParse(json['match_seq']),
      match: json['match'],
      ticketWon: json['ticket_won'],
      prize: json['prize'],
      drawType: json['draw_type']);
}
