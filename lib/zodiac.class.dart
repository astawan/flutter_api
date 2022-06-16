class Zodiac {
  final int id;
  final String photo;
  final String name;
  final String date;
  final String description;

  const Zodiac({
    required this.id,
    required this.photo,
    required this.name,
    required this.date,
    required this.description,
  });

  factory Zodiac.fromJson(Map<String, String> json) {
    return Zodiac(
      id: json['id'] as int,
      photo: json['photo'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      description: json['description'] as String,
    );
  }
}
