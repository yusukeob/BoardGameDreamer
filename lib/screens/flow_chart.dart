import 'package:board_game_dreamer/models/project_flow_chart.dart';
import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:board_game_dreamer/services/sqlite_project_flow_charts_service.dart';
// import 'package:flutter_flow_chart/flutter_flow_chart.dart';

class FlowChartPage extends StatefulWidget {
  final int projectId;
  final int flowChartId;
  const FlowChartPage(
      {super.key, required this.projectId, required this.flowChartId});

  static const String pageName = "Flow Chart";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<FlowChartPage> createState() => _FlowChartPageState();
}

class _FlowChartPageState extends State<FlowChartPage> {
  int projectId = 0;
  late Project project = const Project(id: 0, projectname: "", userid: 0);
  int flowChartId = 0;
  late ProjectFlowChart flowChart =
      const ProjectFlowChart(id: 0, flowchartname: "", userid: 0, projectid: 0);

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    flowChartId = widget.flowChartId;
    _getUserProject();
    _getUserProjectFlowChart();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _getUserProjectFlowChart() async {
    flowChart = await SqliteProjectFlowChartsService()
        .getUserProjectFlowChart(flowChartId);
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
                    child: Text(
                      flowChart.flowchartname,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
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
