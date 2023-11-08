class UnitMeasure {
  final int id;
  final String name;

  UnitMeasure({required this.id, required this.name});

  factory UnitMeasure.fromJson(Map<String, dynamic> json) =>
      UnitMeasure(id: json['code_id'], name: json['code_name']);
}
