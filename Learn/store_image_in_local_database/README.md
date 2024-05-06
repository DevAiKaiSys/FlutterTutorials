# store_image_in_local_database

```
flutter pub add hive
flutter pub add hive_flutter
```

```
flutter pub add isar
flutter pub add isar_flutter_libs
flutter pub add path_provider
```

```
dart pub add dev:hive_generator
dart pub add dev:isar_generator
dart pub add dev:build_runner
```

### generate

```
flutter pub run build_runner build --delete-conflicting-outputs
# OR
dart run build_runner build --delete-conflicting-outputs
```

### run test

```
flutter test
or
flutter test test/data/repositories/movie_repository_impl_test.dart
```