class Festival {
  final String id;
  final String name;
  final String start_date;
  final String end_date;
  final String stages;

  Festival({
    required this.id,
    required this.name,
    required this.start_date,
    required this.end_date,
    required this.stages
  });
  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
        id: json['id'],
        name: json['name'],
        start_date: json['start_date'],
        end_date: json['end_date'],
        stages: json['stages']
    );
  }
}