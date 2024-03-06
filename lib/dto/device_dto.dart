class DeviceDto {
  int? deviceId;
  String deviceMac;
  int employeeId;

  DeviceDto({this.deviceId, required this.deviceMac, required this.employeeId});

  factory DeviceDto.fromJson(Map<String, dynamic> json) {
    return DeviceDto(
      deviceId: json['deviceId'],
      deviceMac: json['deviceMac'],
      employeeId: json['employeeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceMac': deviceMac,
      'employeeId': employeeId,
    };
  }

  @override
  String toString() {
    return 'DeviceDto{deviceId: $deviceId, deviceMac: $deviceMac, employeeId: $employeeId}';
  }
}