import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
// import 'package:board_game_dreamer/models/project.dart';
// import 'package:board_game_dreamer/services/sqlite_project_service.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  static const String pageName = "Project";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
