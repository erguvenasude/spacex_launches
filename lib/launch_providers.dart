import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'launch_repo.dart';
import 'launch_model.dart';

/// Provider for fetching the list of launches
final launchesFutureProvider = FutureProvider<List<Launch>>((ref) async {
  final repo = ref.watch(launchesRepoProvider);
  return repo.upcoming();
});

/// Tracks which panel is expanded (only one at a time)
final expandedIdProvider = StateProvider<String?>((_) => null);

/// StateNotifier to keep track of how many times each mission is opened
class OpenCounts extends StateNotifier<Map<String, int>> {
  OpenCounts() : super({});

  void increment(String id) {
    state = {
      ...state,
      id: (state[id] ?? 0) + 1,
    };
  }
}

/// Provider for the open counts map
final openCountsProvider =
StateNotifierProvider<OpenCounts, Map<String, int>>((_) => OpenCounts());
