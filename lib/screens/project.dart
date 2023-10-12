import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/screens/flow_charts.dart';
import 'package:board_game_dreamer/screens/mechanics.dart';
import 'package:board_game_dreamer/screens/files.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';

class ProjectPage extends StatefulWidget {
  final int projectId;
  const ProjectPage({super.key, required this.projectId});

  static const String pageName = "Project";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  int projectId = 0;
  late Project project = const Project(id: 0, projectname: "", userid: 0);
  final List<String> projectMenu = <String>[
    "Flow Charts",
    "Mechanics",
    "Files",
    "Notes"
  ];

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    _getUserProject();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _goToMenu(String menuItem) {
    if (menuItem == "Flow Charts") {
      _goToFlowCharts();
    } else if (menuItem == "Mechanics") {
      _goToMechanics();
    } else if (menuItem == "Files") {
      _goToFiles();
    }
  }

  void _goToFlowCharts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlowChartsPage(projectId: projectId),
      ),
    );
  }

  void _goToMechanics() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MechanicsPage(projectId: projectId),
      ),
    );
  }

  void _goToFiles() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FilesPage(projectId: projectId),
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 8.0, right: 8.0, bottom: 16.0),
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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: projectMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(projectMenu[index]),
                        shape: const Border(
                          top: BorderSide(color: Colors.lightBlue, width: 0),
                          right: BorderSide(color: Colors.lightBlue, width: 0),
                          left: BorderSide(color: Colors.lightBlue, width: 0),
                          bottom: BorderSide(color: Colors.lightBlue, width: 1),
                        ),
                        onTap: () {
                          _goToMenu(projectMenu[index]);
                        },
                      );
                    },
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
