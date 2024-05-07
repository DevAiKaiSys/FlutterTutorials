import 'package:isar/isar.dart';
import 'package:routine_app/domain/entities/routine.entity.dart';

import 'category.dart';

@Collection()
class Routine {
  Id? id;
  late String title;
  @Index()
  late DateTime startTime;
  @Index(caseSensitive: false)
  late String day;
  @Index(composite: [CompositeIndex('title')])
  final category = IsarLink<Category>();

  RoutineEntity toEntity() {
    return RoutineEntity(
        title: title,
        startTime: startTime,
        day: day,
        category: (category.value as Category).toEntity());
  }
}
