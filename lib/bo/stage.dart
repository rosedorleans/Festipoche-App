class Event {
  final String id;
  final String nom;
  final String contact;

  Event({
    required this.id,
    required this.nom,
    required this.contact
  });
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        nom: json['nom'],
        contact: json['contact']
    );
  }
}