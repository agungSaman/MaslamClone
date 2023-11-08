class CodeMstr {
  final int id;
  final String name;
  final int status;

  CodeMstr({required this.id, required this.name, this.status = 0});

  factory CodeMstr.fromJson(Map<String, dynamic> json) => CodeMstr(
      id: json['code_id'],
      name: json['code_name'],
      status: json['status'] ?? 0);

  Map<String, dynamic> toJson() =>
      {'code_id': id, 'code_name': name, 'status': status};
}
