class Artist {
  final String id;
  final String name;
  final String event;

  Artist({
    required this.id,
    required this.name,
    required this.event
  });
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
        id: json['id'],
        name: json['name'],
        event: json['event']
    );
  }
}