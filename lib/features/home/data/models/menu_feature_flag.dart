class MenuFeatureFlag {
  final String menuName;
  final bool isEnabled;

  MenuFeatureFlag({required this.menuName, required this.isEnabled});

  factory MenuFeatureFlag.fromJson(Map<String, dynamic> json) =>
      MenuFeatureFlag(
          menuName: json['menu_name'], isEnabled: json['visiblemobilestatus']);
}
