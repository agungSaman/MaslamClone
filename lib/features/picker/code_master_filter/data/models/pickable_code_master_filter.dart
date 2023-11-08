class PickableCodeMasterFilter {
  final int id;
  final String value;

  PickableCodeMasterFilter({required this.id, required this.value});

  factory PickableCodeMasterFilter.fromJson(Map<String, dynamic> json) =>
      PickableCodeMasterFilter(
          id: json['code_id'],
          value: (json['code_name'] as String).isNotEmpty
              ? json['code_name']
              : '-');
}
