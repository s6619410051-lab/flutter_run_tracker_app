class Run {
  String? id;
  String createdAt;
  String runWhere;
  String runPerson;
  int runDistance;

  Run({
    this.id,
    required this.createdAt,
    required this.runWhere,
    required this.runPerson,
    required this.runDistance,
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
      id: json['id'],
      createdAt: json['created_at'],
      runWhere: json['runWhere'],
      runPerson: json['runPerson'],
      runDistance: json['runDistance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "runWhere": runWhere,
      "runPerson": runPerson,
      "runDistance": runDistance,
    };
  }
}
