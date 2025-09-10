import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Basic GraphQL client (can be used without Riverpod if needed)
GraphQLClient getGraphQLClient() {
  final link = HttpLink('https://spacex-production.up.railway.app/');
  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: link,
  );
}

/// Riverpod provider for GraphQL client
final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  final link = HttpLink('https://spacex-production.up.railway.app/');
  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: link,
  );
});
