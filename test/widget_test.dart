import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_launches/main.dart' as app;

void main() {
  testWidgets('app boots with ProviderScope', (tester) async {
    // Minimal smoke test: just build the app wrapped in ProviderScope.
    await tester.pumpWidget(const ProviderScope(child: app.MyApp()));
    await tester.pumpAndSettle();

    // If we reach here without exceptions, the boot is OK.
    expect(true, isTrue);
  });
}
