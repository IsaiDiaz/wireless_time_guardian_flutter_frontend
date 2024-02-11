class EmployeeDto{

  int id;
  String fullName;
  String ci;
  bool update;
  bool isPresentRfid;
  bool isPresentWifi;

  EmployeeDto({required this.id, required this.fullName, required this.ci, required this.update, required this.isPresentRfid, required this.isPresentWifi});

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      id: json['id'],
      fullName: json['fullName'],
      ci: json['ci'],
      update: json['update'],
      isPresentRfid: json['isPresentRfid'],
      isPresentWifi: json['isPresentWifi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'ci': ci,
      'update': update,
      'isPresentRfid': isPresentRfid,
      'isPresentWifi': isPresentWifi,
    };
  }

  @override
  String toString() {
    return 'EmployeeDto{id: $id, fullName: $fullName, ci: $ci, update: $update, isPresentRfid: $isPresentRfid, isPresentWifi: $isPresentWifi}';
  }

}