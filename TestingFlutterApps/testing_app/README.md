# [testing_app](https://codelabs.developers.google.com/codelabs/flutter-app-testing)

A new Flutter project.

```
flutter pub add provider go_router dev:test 'dev:flutter_driver:{"sdk":"flutter"}' 'dev:integration_test:{"sdk":"flutter"}'
flutter pub add provider
flutter pub add go_router
flutter pub add dev:test
flutter pub add "dev:flutter_driver:{'sdk':'flutter'}"
flutter pub add "dev:integration_test:{'sdk':'flutter'}"
```

## Run the test

```
flutter test
or
flutter test test/models/favorites_test.dart
```

### Integration tests

```
flutter test integration_test/app_test.dart
```
