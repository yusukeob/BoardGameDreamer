class File {
  final int id;
  String filename;
  String filecontent;
  final int userid;
  final int projectid;

  File({
    required this.id,
    required this.filename,
    required this.filecontent,
    required this.userid,
    required this.projectid,
  });

  static final columns = [
    "id",
    "filename",
    "filecontent",
    "userid",
    "projectid",
  ];

  factory File.fromMap(Map<dynamic, dynamic> data) {
    return File(
      id: data['id'],
      filename: data['filename'],
      filecontent: data['filecontent'],
      userid: data['userid'],
      projectid: data['projectid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'filename': filename,
      'filecontent': filecontent,
      'userid': userid,
      'projectid': projectid,
    };
  }

  @override
  String toString() {
    return 'File{id: $id, filename: $filename, filecontent: $filecontent, userid: $userid, projectid: $projectid}';
  }
}
