import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spacex_launches/launch_providers.dart';
import 'package:spacex_launches/launch_model.dart';
import 'package:spacex_launches/main.dart' as app;

void main() {
  testWidgets('shows missions and expands to reveal details', (tester) async {
    // Arrange: fake data to avoid real network calls
    final fakeData = <Launch>[
      Launch(
        id: '1',
        missionName: 'Test Mission 1',
        rocketName: 'Falcon 9',
        launchUtc: DateTime.utc(2025, 1, 1, 12, 0, 0),
      ),
      Launch(
        id: '2',
        missionName: 'Test Mission 2',
        rocketName: 'Falcon Heavy',
        launchUtc: DateTime.utc(2025, 2, 1, 12, 0, 0),
      ),
    ];

    // Build app with provider override for the future
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          launchesFutureProvider.overrideWith((ref) async => fakeData),
        ],
        child: const app.MyApp(),
      ),
    );

    // Let the widget settle after async build
    await tester.pumpAndSettle();

    // Both mission names should be visible
    expect(find.text('Test Mission 1'), findsOneWidget);
    expect(find.text('Test Mission 2'), findsOneWidget);

    // Act: tap to expand first mission
    await tester.tap(find.text('Test Mission 1'));
    await tester.pumpAndSettle();

    // Assert: details should be visible (rocket line)
    expect(find.textContaining('Rocket:'), findsWidgets);
  });
}
