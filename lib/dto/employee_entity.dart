class EmployeeEntity{

  String name;
  String ci;
  
  EmployeeEntity({required this.name, required this.ci});

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) {
    return EmployeeEntity(
      name: json['name'],
      ci: json['ci'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ci': ci,
    };
  }

  @override
  String toString() {
    return 'EmployeeEntity{name: $name, ci: $ci}';
  }



}