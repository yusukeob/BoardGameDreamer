class ProjectFlowChart {
  final int id;
  final String flowchartname;
  final int userid;
  final int projectid;

  const ProjectFlowChart({
    required this.id,
    required this.flowchartname,
    required this.userid,
    required this.projectid,
  });

  static final columns = ["id", "flowchartname", "userid", "projectid"];

  factory ProjectFlowChart.fromMap(Map<dynamic, dynamic> data) {
    return ProjectFlowChart(
      id: data['id'],
      flowchartname: data['flowchartname'],
      userid: data['userid'],
      projectid: data['projectid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'flowchartname': flowchartname,
      'userid': userid,
      'projectid': projectid,
    };
  }

  @override
  String toString() {
    return 'ProjectFlowChart{id: $id, flowchartname: $flowchartname, userid: $userid, projectid: $projectid}';
  }
}
