import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';

class FlowChartsPage extends StatefulWidget {
  final int projectId;
  const FlowChartsPage({super.key, required this.projectId});

  static const String pageName = "Flow Charts";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<FlowChartsPage> createState() => _FlowChartPageState();
}

class _FlowChartPageState extends State<FlowChartsPage> {
  int projectId = 0;
  late Project project = const Project(id: 0, projectname: "", userid: 0);
  late List<FlowChart> flowCharts = <FlowChart>[];

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    _getUserProject();
    _getUserFlowCharts();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _getUserFlowCharts() async {
    // flowcharts = await SqliteFlowChartsService().getUserFlowCharts(projectId);
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
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
          ),
        ),
      ),
    );
  }
}
