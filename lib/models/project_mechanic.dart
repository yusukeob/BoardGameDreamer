class ProjectMechanic {
  final int id;
  String mechanicname;
  String mechanicexplanation;
  final int userid;
  final int projectid;
  int mechanicid;
  String projectapplication;

  ProjectMechanic({
    required this.id,
    required this.mechanicname,
    required this.mechanicexplanation,
    required this.userid,
    required this.projectid,
    required this.mechanicid,
    required this.projectapplication,
  });

  static final columns = [
    "id",
    "mechanicname",
    "mechanicexplanation",
    "userid",
    "projectid",
    "mechanicid",
    "projectapplication"
  ];

  factory ProjectMechanic.fromMap(Map<dynamic, dynamic> data) {
    return ProjectMechanic(
      id: data['id'],
      mechanicname: data['mechanicname'],
      mechanicexplanation: data['mechanicexplanation'],
      userid: data['userid'],
      projectid: data['projectid'],
      mechanicid: data['mechanicid'],
      projectapplication: data['projectapplication'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'mechanicname': mechanicname,
      'mechanicexplanation': mechanicexplanation,
      'userid': userid,
      'projectid': projectid,
      'mechanicid': mechanicid,
      'projectapplication': projectapplication,
    };
  }

  @override
  String toString() {
    return 'ProjectMechanic{id: $id, mechanicname: $mechanicname, mechanicexplanation: $mechanicexplanation, userid: $userid, projectid: $projectid, mechanicid: $mechanicid, projectapplication: $projectapplication}';
  }
}
