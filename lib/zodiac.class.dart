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

  factory Zodiac.fromJson(Map<dynamic, dynamic> json) {
    return Zodiac(
      id: int.parse(json['id']),
      photo: json['photo'],
      name: json['name'],
      date: json['date'],
      description: json['description'],
    );
  }
}
