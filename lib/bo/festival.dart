class Stage {
  final String id;
  final String nom;
  final String contact;

  Stage({
    required this.id,
    required this.nom,
    required this.contact
  });
  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
        id: json['id'],
        nom: json['nom'],
        contact: json['contact']
    );
  }
}