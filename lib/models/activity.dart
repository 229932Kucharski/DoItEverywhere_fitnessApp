class Activity {
  String? name;
  String? icon;
  int? points;
  bool? isGpsRequired;

  Activity({
    required this.name,
    required this.icon,
    required this.points,
    required this.isGpsRequired,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "icon": icon,
      "points": points,
      "isGpsRequired": isGpsRequired
    };
  }
}
