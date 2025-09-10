import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_launches/launch_model.dart';

void main() {
  group('Launch.fromJson', () {
    test('parses required fields and UTC date', () {
      // Arrange
      final json = {
        'id': 'abc123',
        'mission_name': 'Demo Mission',
        'rocket': {'rocket_name': 'Falcon 9'},
        'launch_date_utc': '2025-01-01T12:00:00.000Z',
      };

      // Act
      final launch = Launch.fromJson(json);

      // Assert
      expect(launch.id, 'abc123');
      expect(launch.missionName, 'Demo Mission');
      expect(launch.rocketName, 'Falcon 9');
      expect(launch.launchUtc.toUtc().year, 2025);
      expect(launch.launchUtc.toUtc().hour, 12); // 12:00Z
    });

    test('uses fallback values when optional fields are missing', () {
      // Arrange: mission_name and rocket_name are missing
      final json = {
        'id': 'no-name',
        'launch_date_utc': '2025-02-02T00:00:00.000Z',
      };

      // Act
      final launch = Launch.fromJson(json);

      // Assert
      expect(launch.missionName, 'Unknown');
      expect(launch.rocketName, 'Unknown');
    });
  });
}
