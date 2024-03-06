class ProjectDto{

  int? projectId;
  String projectName;
  DateTime projectInitialDate;
  DateTime? projectFinalDate;
  bool projectIsCurrent;

  ProjectDto({
    this.projectId,
    required this.projectName,
    required this.projectInitialDate,
    this.projectFinalDate,
    required this.projectIsCurrent
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json){
    return ProjectDto(
      projectId: json['projectId'],
      projectName: json['projectName'],
      projectInitialDate: DateTime.parse(json['projectInitialDate']),
      projectFinalDate: json['projectFinalDate'] != null ? DateTime.parse(json['projectFinalDate']) : null,
      projectIsCurrent: json['projectIsCurrent']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'projectId': projectId,
      'projectName': projectName,
      'projectInitialDate': projectInitialDate.toIso8601String(),
      'projectFinalDate': projectFinalDate?.toIso8601String(),
      'projectIsCurrent': projectIsCurrent
    };
  }

  @override
  String toString() {
    return 'ProjectDto{projectId: $projectId, projectName: $projectName, projectInitialDate: $projectInitialDate, projectFinalDate: $projectFinalDate, projectIsCurrent: $projectIsCurrent}';
  }
}