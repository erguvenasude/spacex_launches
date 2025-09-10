/// Data model for a launch
class Launch {
  final String id;
  final String missionName;
  final String rocketName;
  final DateTime launchUtc;

  Launch({
    required this.id,
    required this.missionName,
    required this.rocketName,
    required this.launchUtc,
  });

  /// Factory constructor to create a Launch from JSON
  factory Launch.fromJson(Map<String, dynamic> j) => Launch(
    id: j['id'] as String,
    missionName: (j['mission_name'] as String?) ?? 'Unknown',
    rocketName: (j['rocket']?['rocket_name'] as String?) ?? 'Unknown',
    launchUtc: DateTime.parse(j['launch_date_utc'] as String),
  );
}
