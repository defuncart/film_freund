# film_freund

An application to discover new films and organize what to watch next.

## Getting Started

If you would like to build the app yourself, then you simply need:

- Flutter stable >= 2.5
- Dart >= 2.14
- macOS:
    - Xcode >= 12.4
    - CocoaPods >= 1.11.0
- web:
    - Chrome

Also you need to create a Firebase project and [integrate it](https://firebase.google.com/docs/flutter/setup) into this project.

## Code Generation

### Localizations

To add new localizations, update `assets_dev/loca/loca.csv` and run

```sh
sh bin/loca_generate.sh
```

## Credits

This application is developed for personal use, and is inspired by Letterbox, iMDb and Filmweb.

## Raising Issues and Contributing

Please report bugs and issues, and raise feature requests [here](https://github.com/defuncart/film_freund/issues).

To contribute, submit a PR with a detailed description and tests, if applicable.
