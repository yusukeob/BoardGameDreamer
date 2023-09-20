class Project {
  final int id;
  final String projectname;
  final int userid;

  const Project({
    required this.id,
    required this.projectname,
    required this.userid,
  });

  static final columns = ["id", "projectname", "userid"];

  factory Project.fromMap(Map<dynamic, dynamic> data) {
    return Project(
      id: data['id'],
      projectname: data['projectname'],
      userid: data['userid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'projectname': projectname,
      'userid': userid,
    };
  }

  @override
  String toString() {
    return 'Project{id: $id, projectname: $projectname, userid: $userid}';
  }
}
