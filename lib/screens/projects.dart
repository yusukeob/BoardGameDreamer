import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:board_game_dreamer/screens/project.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  static const String pageName = "Projects";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _addProject = true;
  String _projectname = "";
  late List<Project> projectList = <Project>[];

  @override
  void initState() {
    super.initState();
    _getUserProjects();
  }

  void _switchAddProject() {
    setState(() {
      _addProject = !_addProject;
    });
  }

  void _getUserProjects() async {
    projectList = await SqliteProjectsService().getUserProjects(1);
    setState(() {});
  }

  void _addNewProject() async {
    if (_projectname != "") {
      Project project = Project(id: 0, projectname: _projectname, userid: 1);
      int success = await SqliteProjectsService().createProject(project);
      if (success > 0) {
        _switchAddProject();
        _getUserProjects();
      }
    }
    setState(() {});
  }

  void _goToProject(int projectId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProjectPage(projectId: projectId),
      ),
    );
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: _addProject,
                  child: SizedBox(
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
                        onPressed: _switchAddProject,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_addProject,
                  child: SizedBox(
                    height: 150,
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.green,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        iconSize: 100,
                        icon: const Icon(Icons.check),
                        color: Colors.white,
                        onPressed: _addNewProject,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Visibility(
                    visible: !_addProject,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Project Name',
                        ),
                        onChanged: (text) {
                          _projectname = text;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: projectList.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: projectList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(projectList[index].projectname),
                          shape: const Border(
                            top: BorderSide(color: Colors.lightBlue, width: 0),
                            right:
                                BorderSide(color: Colors.lightBlue, width: 0),
                            left: BorderSide(color: Colors.lightBlue, width: 0),
                            bottom:
                                BorderSide(color: Colors.lightBlue, width: 1),
                          ),
                          onTap: () {
                            _goToProject(projectList[index].id);
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
