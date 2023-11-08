extension StringUtil on dynamic {
  String get dashIfNull {
    if (this is String) {
      return this ?? '-';
    } else {
      return this != null ? toString() : '-';
    }
  }
}
