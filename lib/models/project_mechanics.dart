import 'package:board_game_dreamer/models/project_mechanic.dart';
import 'package:flutter/material.dart';

class ProjectMechanicsProvider extends ChangeNotifier {
  final List<ProjectMechanic> _projectMechanics = [];

  List<ProjectMechanic> get projectMechanics => _projectMechanics;
  List<String> get projectMechanicNames =>
      _projectMechanics.map((pm) => pm.mechanicname).toList();

  void add(ProjectMechanic projectMechanic) {
    _projectMechanics.add(projectMechanic);
    notifyListeners();
  }

  void remove(int index) {
    _projectMechanics.removeAt(index);
    notifyListeners();
  }

  int getLength() {
    return _projectMechanics.length;
  }
}
