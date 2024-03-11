class EmployeeAdvanceDto {
  int? employeAdvanceId;
  double employeAdvanceAmount;
  DateTime employeAdvanceDate;
  int? projectEmployeId;

  EmployeeAdvanceDto({
    this.employeAdvanceId,
    required this.employeAdvanceAmount,
    required this.employeAdvanceDate,
    this.projectEmployeId,
  });

  factory EmployeeAdvanceDto.fromJson(Map<String, dynamic> json) {
    return EmployeeAdvanceDto(
      employeAdvanceId: json['employeAdvanceId'],
      employeAdvanceAmount: json['employeAdvanceAmount'],
      employeAdvanceDate: DateTime.fromMillisecondsSinceEpoch(
          json['employeAdvanceDate'],
          isUtc: true),
      projectEmployeId: json['projectEmployeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeAdvanceId': employeAdvanceId,
      'employeAdvanceAmount': employeAdvanceAmount,
      'employeAdvanceDate': employeAdvanceDate.toUtc().millisecondsSinceEpoch,
      'projectEmployeId': projectEmployeId,
    };
  }

  @override
  String toString() {
    return 'EmployeeAdvanceDto{employeAdvanceId: $employeAdvanceId, employeAdvanceAmount: $employeAdvanceAmount, employeAdvanceDate: $employeAdvanceDate, projectEmployeId: $projectEmployeId}';
  }
}