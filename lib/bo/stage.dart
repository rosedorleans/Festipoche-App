class Stage {
  final String id;
  final String name;
  final String festival;
  final String events;

  Stage({
    required this.id,
    required this.name,
    required this.festival,
    required this.events
  });
  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
        id: json['id'],
        name: json['name'],
        festival: json['festival'],
        events: json['events']
    );
  }
}