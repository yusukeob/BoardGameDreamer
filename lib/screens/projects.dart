import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  static const String pageName = "Projects";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _addProject = true;

  void _switchAddProject() {
    setState(() {
      _addProject = !_addProject;
    });
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: _addProject,
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
                Visibility(
                  visible: !_addProject,
                  child: const Text("hello"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
