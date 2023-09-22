import 'package:board_game_dreamer/models/project_flow_chart.dart';
import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:board_game_dreamer/services/sqlite_project_flow_charts_service.dart';
import 'dart:io';

import 'package:flutter_flow_chart/flutter_flow_chart.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:star_menu/star_menu.dart';

import 'element_settings_menu.dart';
import 'text_menu.dart';

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
  Dashboard dashboard = Dashboard();
  double flowChartHeight = 0;
  final GlobalKey<_FlowChartPageState> key = GlobalKey<_FlowChartPageState>();
  double initScreenHeight = 1;
  double flowChartOffset = 0;

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    flowChartId = widget.flowChartId;
    _getUserProject();
    _getUserProjectFlowChart();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calcFlowChartHeight());
  }

  void _calcFlowChartHeight() {
    initScreenHeight = MediaQuery.of(context).size.height;
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    flowChartOffset = position.dy;
    setState(() {});
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

  _displayHandlerMenu(
    Offset position,
    Handler handler,
    FlowElement element,
  ) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            space: 10,
          ),
          onHoverScale: 1.1,
          useTouchAsCenter: true,
          centerOffset: position -
              Offset(
                dashboard.dashboardSize.width / 2,
                dashboard.dashboardSize.height / 2,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        items: [
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () =>
                dashboard.removeElementConnection(element, handler),
          )
        ],
        parentContext: context,
      ),
    );
  }

  /// Display a drop down menu when tapping on an element
  _displayElementMenu(
    BuildContext context,
    Offset position,
    FlowElement element,
  ) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          onHoverScale: 1.1,
          centerOffset: position - const Offset(50, 0),
          backgroundParams: const BackgroundParams(
            backgroundColor: Colors.transparent,
          ),
          boundaryBackground: BoundaryBackground(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              boxShadow: kElevationToShadow[6],
            ),
          ),
        ),
        onItemTapped: (index, controller) {
          if (!(index == 5 || index == 2)) {
            controller.closeMenu!();
          }
        },
        items: [
          Text(
            element.text,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          InkWell(
            onTap: () => dashboard.removeElement(element),
            child: const Text('Delete'),
          ),
          TextMenu(element: element),
          InkWell(
            onTap: () {
              dashboard.removeElementConnections(element);
            },
            child: const Text('Remove all connections'),
          ),
          InkWell(
            onTap: () {
              dashboard.setElementResizable(element, true);
            },
            child: const Text('Resize'),
          ),
          ElementSettingsMenu(
            element: element,
          ),
        ],
        parentContext: context,
      ),
    );
  }

  _displayDashboardMenu(BuildContext context, Offset position) {
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.linear,
          openDurationMs: 60,
          linearShapeParams: const LinearShapeParams(
            angle: 270,
            alignment: LinearAlignment.left,
            space: 10,
          ),
          // calculate the offset from the dashboard center
          centerOffset: position -
              Offset(
                dashboard.dashboardSize.width / 2,
                dashboard.dashboardSize.height / 2,
              ),
        ),
        onItemTapped: (index, controller) => controller.closeMenu!(),
        parentContext: context,
        items: [
          ActionChip(
              label: const Text('Add diamond'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(40, 40),
                    size: const Size(80, 80),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.diamond,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add rect'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.rectangle,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add oval'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.oval,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add parallelogram'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 50),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.parallelogram,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.topCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Add storage'),
              onPressed: () {
                dashboard.addElement(FlowElement(
                    position: position - const Offset(50, 25),
                    size: const Size(100, 150),
                    text: '${dashboard.elements.length}',
                    kind: ElementKind.storage,
                    handlers: [
                      Handler.bottomCenter,
                      Handler.leftCenter,
                      Handler.rightCenter,
                    ]));
              }),
          ActionChip(
              label: const Text('Remove all'),
              onPressed: () {
                dashboard.removeAllElements();
              }),
          ActionChip(
              label: const Text('SAVE dashboard'),
              onPressed: () async {
                Directory appDocDir =
                    await path.getApplicationDocumentsDirectory();
                dashboard.saveDashboard('${appDocDir.path}/FLOWCHART.json');
              }),
          ActionChip(
              label: const Text('LOAD dashboard'),
              onPressed: () async {
                Directory appDocDir =
                    await path.getApplicationDocumentsDirectory();
                dashboard.loadDashboard('${appDocDir.path}/FLOWCHART.json');
              }),
        ],
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
                SizedBox(
                  key: key,
                  width: MediaQuery.of(context).size.width,
                  height: (initScreenHeight *
                          (MediaQuery.of(context).size.height /
                              initScreenHeight)) -
                      flowChartOffset,
                  child: FlowChart(
                    dashboard: dashboard,
                    onDashboardTapped: ((context, position) {
                      debugPrint('Dashboard tapped $position');
                      _displayDashboardMenu(context, position);
                    }),
                    onDashboardLongtTapped: ((context, position) {
                      debugPrint('Dashboard long tapped $position');
                    }),
                    onElementLongPressed: (context, position, element) {
                      debugPrint('Element with "${element.text}" text '
                          'long pressed');
                    },
                    onElementPressed: (context, position, element) {
                      debugPrint('Element with "${element.text}" text pressed');
                      _displayElementMenu(context, position, element);
                    },
                    onHandlerPressed: (context, position, handler, element) {
                      debugPrint('handler pressed: position $position '
                          'handler $handler" of element $element');
                      _displayHandlerMenu(position, handler, element);
                    },
                    onHandlerLongPressed:
                        (context, position, handler, element) {
                      debugPrint('handler long pressed: position $position '
                          'handler $handler" of element $element');
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
