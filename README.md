# film_freund

An application to discover new films and organize what to watch next.

## Getting Started

To build the app locally, the following tools are required:

- Flutter stable >= 2.5
- Dart >= 2.14
- macOS:
    - Xcode >= 12.4
    - CocoaPods >= 1.11.0
- Web:
    - Chrome

A Firebase project needs to be created and [integrated](https://firebase.google.com/docs/flutter/setup). Note that to speed up development build times, a [pre-compiled version of Firestore](https://github.com/invertase/firestore-ios-sdk-frameworks#supported-firebase-ios-sdk-versions) on iOS and macOS is used.

An [API key](https://developers.themoviedb.org/3/getting-started/introduction) is needed to query TMDB. Once a key is obtained, create the file `lib/services/movies/movie_database.secrets.dart` with the content:

```dart
part of 'movie_database.dart';

const apiKey = 'apiKey';
```

where apiKey is the TMDB v3 api key.

## Code Generation

### Localizations

To add new localizations, update `assets_dev/loca/loca.csv` and run

```sh
sh bin/loca_generate.sh
```

## Credits

This application is developed for personal use, and is inspired by Letterbox, iMDb and Filmweb. This product uses the TMDB API but is not endorsed or certified by TMDB.

## Raising Issues and Contributing

Please report bugs and issues, and raise feature requests [here](https://github.com/defuncart/film_freund/issues).

To contribute, submit a PR with a detailed description and tests, if applicable.
