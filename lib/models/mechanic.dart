class Mechanic {
  final int id;
  final String mechanicname;
  final String mechanicexplanation;

  const Mechanic({
    required this.id,
    required this.mechanicname,
    required this.mechanicexplanation,
  });

  static final columns = [
    "id",
    "mechanicname",
    "mechanicexplanation",
  ];

  factory Mechanic.fromMap(Map<dynamic, dynamic> data) {
    return Mechanic(
      id: data['id'],
      mechanicname: data['mechanicname'],
      mechanicexplanation: data['mechanicexplanation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'mechanicname': mechanicname,
      'mechanicexplanation': mechanicexplanation,
    };
  }

  @override
  String toString() {
    return 'Mechanic{id: $id, mechanicname: $mechanicname, mechanicexplanation: $mechanicexplanation}';
  }
}
