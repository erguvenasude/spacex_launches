# SpaceX Launches (Flutter Web)

A simple Flutter web application that lists **upcoming SpaceX launches** using the public SpaceX GraphQL API.

- **ST-01:** Show a compact list of mission names.
- **ST-02:** Each mission can be expanded to show details (rocket name and local launch time). Only one panel can be expanded at a time.
- **ST-03:** Keep track of how many times each mission has been opened. Each expansion logs a simple key-value map `{ missionId: count }` to the browser console.

---

## Technologies

- **Flutter (Web)**
- **GraphQL API**: https://spacex-production.up.railway.app/
- **Packages**:
    - `graphql_flutter`
    - `flutter_riverpod`
    - `intl`

---

## Installation

Install dependencies:
```bash
flutter pub get
