class Artist {
  final String id;
  final String nom;
  final String contact;

  Artist({
    required this.id,
    required this.nom,
    required this.contact
  });
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
        id: json['id'],
        nom: json['nom'],
        contact: json['contact']
    );
  }
}