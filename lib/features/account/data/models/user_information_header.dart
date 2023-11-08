class UserInformationHeader {
  final String empoid;
  final String nik;
  final String empname;
  final String department;
  final String position;

  UserInformationHeader(
      {required this.empoid,
      required this.nik,
      required this.empname,
      required this.department,
      required this.position});

  factory UserInformationHeader.fromJson(Map<String, dynamic> json) =>
      UserInformationHeader(
          empoid: json['emp_oid'] ?? '',
          nik: json['emp_code'] ?? '',
          empname: json['emp_name'] ?? '',
          department: json['department'] ?? '-',
          position: json['job_label'] ?? '-');

  Map<String, dynamic> toJson() => {
        'emp_oid': empoid,
        'emp_code': nik,
        'emp_name': empname,
        'department': department,
        'job_label': position
      };
}
