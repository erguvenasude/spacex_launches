import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'launch_query.dart';
import 'launch_model.dart';
import 'graphql_client.dart';

/// Provider for LaunchesRepo
final launchesRepoProvider = Provider<LaunchesRepo>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return LaunchesRepo(client);
});

/// Repository responsible for fetching launch data
class LaunchesRepo {
  final GraphQLClient _client;
  LaunchesRepo(this._client);

  /// Fetch upcoming launches from the SpaceX GraphQL API
  Future<List<Launch>> upcoming() async {
    final result = await _client.query(
      QueryOptions(document: gql(launchesUpcomingQuery)),
    );
    if (result.hasException) throw result.exception!;
    final list = (result.data?['launchesUpcoming'] as List? ?? []);
    return list.map((e) => Launch.fromJson(e as Map<String, dynamic>)).toList();
  }
}
