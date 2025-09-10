import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'launch_providers.dart';
import 'launch_model.dart';

void main() {
  // Root for Riverpod state management
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpaceX Launches',
      theme: ThemeData(useMaterial3: true),
      home: const LaunchesPage(),
    );
  }
}

class LaunchesPage extends ConsumerWidget {
  const LaunchesPage({super.key});

  /// Convert UTC time to local time string
  String _fmtLocal(DateTime utc) =>
      DateFormat.yMMMEd().add_Hm().format(utc.toLocal());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchesAsync = ref.watch(launchesFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Launches')),
      body: launchesAsync.when(
        // Loading state
        loading: () => const Center(child: CircularProgressIndicator()),

        // Error state
        error: (e, _) => Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Something went wrong.\n$e'),
            ),
          ),
        ),

        // Data state
        data: (List<Launch> launches) {
          if (launches.isEmpty) {
            return const Center(
              child: Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No upcoming launches.'),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ExpansionPanelList.radio(
                expandedHeaderPadding: EdgeInsets.zero,
                children: launches.map((l) {
                  return ExpansionPanelRadio(
                    value: l.id, // unique mission ID
                    headerBuilder: (_, __) =>
                        ListTile(title: Text(l.missionName)),
                    body: ListTile(
                      title: Text('Rocket: ${l.rocketName}'),
                      subtitle:
                      Text('Launch (local): ${_fmtLocal(l.launchUtc)}'),
                    ),
                  );
                }).toList(),

                // Handle expand/collapse behavior
                expansionCallback: (index, isOpen) {
                  final launch = launches[index];
                  final expandedId = ref.read(expandedIdProvider);

                  if (expandedId != launch.id) {
                    // New mission opened -> increment counter
                    ref.read(openCountsProvider.notifier).increment(launch.id);

                    // Log the full map (missionId -> open count)
                    final counts = ref.read(openCountsProvider);
                    // ignore: avoid_print
                    print(counts);

                    // Update expanded mission ID
                    ref.read(expandedIdProvider.notifier).state = launch.id;
                  } else if (isOpen) {
                    // Collapse if the same mission is tapped again
                    ref.read(expandedIdProvider.notifier).state = null;
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
