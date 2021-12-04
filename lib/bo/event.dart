class Event {
  final String id;
  final String start_datetime;
  final String end_datetime;
  final String stage;
  final String artists;

  Event({
    required this.id,
    required this.start_datetime,
    required this.end_datetime,
    required this.stage,
    required this.artists
  });
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        start_datetime: json['start_datetime'],
        end_datetime: json['end_datetime'],
        stage: json['stage'],
        artists: json['artists']
    );
  }
}