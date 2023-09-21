import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/screens/flow_chart.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/models/project_flow_chart.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:board_game_dreamer/services/sqlite_project_flow_charts_service.dart';

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
  late List<ProjectFlowChart> flowChartList = <ProjectFlowChart>[];
  bool _addFlowChart = true;
  String _flowChartName = "";

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    _getUserProject();
    _getUserProjectFlowCharts();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _getUserProjectFlowCharts() async {
    flowChartList = await SqliteProjectFlowChartsService()
        .getUserProjectFlowCharts(1, projectId);
    setState(() {});
  }

  void _switchAddFlowChart() {
    setState(() {
      _addFlowChart = !_addFlowChart;
    });
  }

  void _addNewFlowChart() async {
    if (_flowChartName != "") {
      ProjectFlowChart projectFlowChart = ProjectFlowChart(
          id: 0,
          flowchartname: _flowChartName,
          userid: 1,
          projectid: projectId);
      int success = await SqliteProjectFlowChartsService()
          .createProjectFlowChart(projectFlowChart);
      if (success > 0) {
        _switchAddFlowChart();
        _getUserProjectFlowCharts();
      }
    }
    setState(() {});
  }

  void _goToFlowChart(int flowChartId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            FlowChartPage(projectId: projectId, flowChartId: flowChartId),
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
                Visibility(
                  visible: _addFlowChart,
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
                        onPressed: _switchAddFlowChart,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_addFlowChart,
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
                        onPressed: _addNewFlowChart,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Visibility(
                    visible: !_addFlowChart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Flow Chart Name',
                        ),
                        onChanged: (text) {
                          _flowChartName = text;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: flowChartList.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: flowChartList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(flowChartList[index].flowchartname),
                          shape: const Border(
                            top: BorderSide(color: Colors.lightBlue, width: 0),
                            right:
                                BorderSide(color: Colors.lightBlue, width: 0),
                            left: BorderSide(color: Colors.lightBlue, width: 0),
                            bottom:
                                BorderSide(color: Colors.lightBlue, width: 1),
                          ),
                          onTap: () {
                            _goToFlowChart(flowChartList[index].id);
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
