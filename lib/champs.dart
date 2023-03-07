class Champs {
  final String champsName;
  final String title;

  const Champs({
    required this.champsName,
    required this.title,
  });

  factory Champs.fromJson(Map<String, dynamic> json) {
    return Champs(
      champsName: json['id'],
      title: json['title'],
    );
  }
}