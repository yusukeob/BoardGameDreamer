import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';
import 'package:board_game_dreamer/models/project.dart';
import 'package:board_game_dreamer/models/project_mechanic.dart';
import 'package:board_game_dreamer/models/mechanic.dart';
import 'package:board_game_dreamer/services/sqlite_projects_service.dart';
import 'package:board_game_dreamer/services/sqlite_project_mechanics_service.dart';
import 'package:board_game_dreamer/services/sqlite_mechanics_service.dart';

class MechanicsPage extends StatefulWidget {
  final int projectId;
  const MechanicsPage({super.key, required this.projectId});

  static const String pageName = "Mechanics";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<MechanicsPage> createState() => _MechanicsPageState();
}

class _MechanicsPageState extends State<MechanicsPage> {
  int projectId = 0;
  int userId = 1;
  late Project project = const Project(id: 0, projectname: "", userid: 0);
  late List<Mechanic> mechanicList = <Mechanic>[];
  late List<ProjectMechanic> projectMechanicList = <ProjectMechanic>[];
  bool _addProjectMechanic = true;
  ProjectMechanic _selectedProjectMechanic = ProjectMechanic(
      id: 0,
      mechanicname: "",
      mechanicexplanation: "",
      projectid: 0,
      userid: 0,
      mechanicid: 0,
      projectapplication: "");
  String selectedMechanicName = "";
  bool _isEditModeProjectMechanicExplanation = false;
  bool _isEditModeProjectMechanicApplication = false;

  @override
  void initState() {
    super.initState();
    projectId = widget.projectId;
    _getUserProject();
    _getMechanics();
    _getProjectMechanics();
  }

  void _getUserProject() async {
    project = await SqliteProjectsService().getUserProject(projectId);
    setState(() {});
  }

  void _getProjectMechanics() async {
    projectMechanicList = await SqliteProjectMechanicsService()
        .getProjectMechanics(userId, projectId);
    setState(() {});
  }

  void _getMechanics() async {
    mechanicList = await SqliteMechanicsService().getMechanics();
    setState(() {});
  }

  void _switchAddProjectMechanic() {
    setState(() {
      _addProjectMechanic = !_addProjectMechanic;
    });
  }

  void _addNewProjectMechanic() async {
    _mechanicNameSelected();
    if (_selectedProjectMechanic.mechanicname != "") {
      ProjectMechanic projectMechanic = ProjectMechanic(
          id: 0,
          mechanicname: _selectedProjectMechanic.mechanicname,
          mechanicexplanation: _selectedProjectMechanic.mechanicexplanation,
          userid: 1,
          projectid: projectId,
          mechanicid: _selectedProjectMechanic.mechanicid,
          projectapplication: _selectedProjectMechanic.projectapplication);
      int success = await SqliteProjectMechanicsService()
          .createProjectMechanic(projectMechanic);
      if (success > 0) {
        selectedMechanicName = "";
        _switchAddProjectMechanic();
        _getProjectMechanics();
      }
    }
    setState(() {});
  }

  void _mechanicNameSelected() {
    _selectedProjectMechanic = ProjectMechanic(
        id: 0,
        mechanicname: selectedMechanicName,
        mechanicexplanation: "",
        projectid: 0,
        userid: 0,
        mechanicid: 0,
        projectapplication: "");

    for (int i = 0; i < mechanicList.length; i++) {
      if (selectedMechanicName == mechanicList[i].mechanicname) {
        _selectedProjectMechanic.mechanicid = mechanicList[i].id;
        _selectedProjectMechanic.mechanicexplanation =
            mechanicList[i].mechanicexplanation;
        break;
      }
    }
    setState(() {});
  }

  _saveProjectMechanicExplanation(ProjectMechanic projectMechanic) {}

  // _editProjectMechanicDescription(ProjectMechanic projectMechanic) {}

  // _editProjectMechanicApplication(ProjectMechanic projectMechanic) {}

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
                      MechanicsPage.pageName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
                Visibility(
                  visible: _addProjectMechanic,
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
                        onPressed: _switchAddProjectMechanic,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_addProjectMechanic,
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
                        onPressed: _addNewProjectMechanic,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Visibility(
                    visible: !_addProjectMechanic,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          selectedMechanicName = textEditingValue.text;
                          return mechanicList
                              .map((e) => e.mechanicname)
                              .where((String mechanicname) {
                            return mechanicname
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          selectedMechanicName = selection;
                          _mechanicNameSelected();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: projectMechanicList.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: projectMechanicList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title:
                                  Text(projectMechanicList[index].mechanicname),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Visibility(
                                        visible:
                                            !_isEditModeProjectMechanicExplanation,
                                        child: Ink(
                                          height: 30,
                                          width: 30,
                                          decoration: const ShapeDecoration(
                                            color: Colors.grey,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            iconSize: 15,
                                            icon: const Icon(Icons.edit),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _isEditModeProjectMechanicExplanation =
                                                    true;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Visibility(
                                            visible:
                                                _isEditModeProjectMechanicExplanation,
                                            child: Ink(
                                              height: 30,
                                              width: 30,
                                              decoration: const ShapeDecoration(
                                                color: Colors.red,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                iconSize: 15,
                                                icon: const Icon(Icons.cancel),
                                                color: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditModeProjectMechanicExplanation =
                                                        false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5)),
                                          Visibility(
                                            visible:
                                                _isEditModeProjectMechanicExplanation,
                                            child: Ink(
                                              height: 30,
                                              width: 30,
                                              decoration: const ShapeDecoration(
                                                color: Colors.green,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                iconSize: 15,
                                                icon: const Icon(Icons.check),
                                                color: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditModeProjectMechanicExplanation =
                                                        false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text("Description: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Visibility(
                                                  visible:
                                                      !_isEditModeProjectMechanicExplanation,
                                                  child: Text(
                                                      projectMechanicList[index]
                                                          .mechanicexplanation),
                                                ),
                                                Visibility(
                                                  visible:
                                                      _isEditModeProjectMechanicExplanation,
                                                  child: TextFormField(
                                                    minLines: 1,
                                                    maxLines: 5,
                                                    initialValue:
                                                        projectMechanicList[
                                                                index]
                                                            .mechanicexplanation,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible:
                                            !_isEditModeProjectMechanicApplication,
                                        child: Ink(
                                          height: 30,
                                          width: 30,
                                          decoration: const ShapeDecoration(
                                            color: Colors.grey,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            iconSize: 15,
                                            icon: const Icon(Icons.edit),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                _isEditModeProjectMechanicApplication =
                                                    true;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Visibility(
                                            visible:
                                                _isEditModeProjectMechanicApplication,
                                            child: Ink(
                                              height: 30,
                                              width: 30,
                                              decoration: const ShapeDecoration(
                                                color: Colors.red,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                iconSize: 15,
                                                icon: const Icon(Icons.cancel),
                                                color: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditModeProjectMechanicApplication =
                                                        false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5)),
                                          Visibility(
                                            visible:
                                                _isEditModeProjectMechanicApplication,
                                            child: Ink(
                                              height: 30,
                                              width: 30,
                                              decoration: const ShapeDecoration(
                                                color: Colors.green,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                iconSize: 15,
                                                icon: const Icon(Icons.check),
                                                color: Colors.white,
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditModeProjectMechanicApplication =
                                                        false;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text("Application: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child:
                                                !_isEditModeProjectMechanicApplication
                                                    ? Text(projectMechanicList[
                                                            index]
                                                        .projectapplication)
                                                    : TextFormField(
                                                        initialValue:
                                                            projectMechanicList[
                                                                    index]
                                                                .projectapplication,
                                                      ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: <Widget>[
                                          TextButton(
                                            onPressed: () => {
                                              _isEditModeProjectMechanicApplication =
                                                  false,
                                              _isEditModeProjectMechanicExplanation =
                                                  false,
                                              Navigator.pop(context, 'OK'),
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(projectMechanicList[index].mechanicname),
                          shape: const Border(
                            top: BorderSide(color: Colors.lightBlue, width: 0),
                            right:
                                BorderSide(color: Colors.lightBlue, width: 0),
                            left: BorderSide(color: Colors.lightBlue, width: 0),
                            bottom:
                                BorderSide(color: Colors.lightBlue, width: 1),
                          ),
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
