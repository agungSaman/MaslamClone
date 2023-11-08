class AttendanceEligibility {
  final int officeId;
  final bool isEligible;

  AttendanceEligibility({required this.officeId, required this.isEligible});

  factory AttendanceEligibility.fromJson(Map<String, dynamic> json) =>
      AttendanceEligibility(
          officeId: json['geo_id'], isEligible: json['geo_status']);
}
