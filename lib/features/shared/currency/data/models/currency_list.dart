class CurrencyList {
  final int id;
  final String name;

  CurrencyList({required this.id, required this.name});

  factory CurrencyList.fromJson(Map<String, dynamic> json) =>
      CurrencyList(id: json['cu_id'], name: json['cu_name']);
}
