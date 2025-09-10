import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_launches/launch_providers.dart';

void main() {
  group('OpenCounts', () {
    test('increments count per mission id', () {
      // Arrange
      final notifier = OpenCounts();

      // Act
      notifier.increment('A'); // A:1
      notifier.increment('A'); // A:2
      notifier.increment('B'); // B:1

      // Assert
      expect(notifier.state['A'], 2);
      expect(notifier.state['B'], 1);
      expect(notifier.state['C'], isNull);
    });
  });
}
