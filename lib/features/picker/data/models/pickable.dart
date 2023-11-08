class Pickable {
  final int id;
  final String value;
  final int? salesPersonId;
  final String? salesPersonName;

  Pickable({
    required this.id,
    required this.value,
    this.salesPersonId,
    this.salesPersonName,
  });

  factory Pickable.fromJson(Map<String, dynamic> json) => Pickable(
        id: json['ptnr_id'],
        value:
            (json['ptnr_name'] as String).isNotEmpty ? json['ptnr_name'] : '-',
        salesPersonId: json['ptnr_sales_id'],
        salesPersonName: json['sp_name'] ?? '-',
      );
}
