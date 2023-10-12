import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/models/file.dart';
import 'package:board_game_dreamer/services/sqlite_files_service.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';

class FilesPage extends StatefulWidget {
  final int projectId;
  const FilesPage({super.key, required this.projectId});

  static const String pageName = "Files";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  int projectId = 0;
  int userId = 1;
  late Project project = const Project(id: 0, projectname: "", userid: 0);
  late List<File> projectFileList = <File>[];

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    _getUserProject();
    _getProjectFiles();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _getProjectFiles() async {
    projectFileList =
        await SqliteFilesService().getProjectFiles(userId, projectId);
    setState(() {});
  }

  void _addNewProjectFile() async {
    //   File projectFile = File(
    //       id: 0,
    //       filename: _selectedProjectMechanic.mechanicname,
    //       filecontent: _selectedProjectMechanic.mechanicexplanation,
    //       userid: 1,
    //       projectid: projectId,);
    //   int success = await SqliteFilesService()
    //       .createProjectFile(projectFile);
    //   if (success > 0) {
    //     _switchAddProjectFile();
    //     _getProjectFiles();
    //   }
    // }
    setState(() {});
  }

  void _showProjectFile() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      project.projectname,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Text(
                      FilesPage.pageName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      iconSize: 100,
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: _addNewProjectFile,
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: projectFileList.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: projectFileList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(projectFileList[index].filename),
                          shape: const Border(
                            top: BorderSide(color: Colors.lightBlue, width: 0),
                            right:
                                BorderSide(color: Colors.lightBlue, width: 0),
                            left: BorderSide(color: Colors.lightBlue, width: 0),
                            bottom:
                                BorderSide(color: Colors.lightBlue, width: 1),
                          ),
                          onTap: () {
                            _showProjectFile();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
