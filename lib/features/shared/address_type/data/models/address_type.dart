class AddressType {
  final int id;
  final String name;

  AddressType({required this.id, required this.name});

  factory AddressType.fromJson(Map<String, dynamic> json) =>
      AddressType(id: json['code_id'], name: json['code_name']);
}
