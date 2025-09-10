/// GraphQL query to fetch upcoming launches
const String launchesUpcomingQuery = r'''
query Upcoming {
  launchesUpcoming {
    id
    mission_name
    rocket { rocket_name }
    launch_date_utc
  }
}
''';
