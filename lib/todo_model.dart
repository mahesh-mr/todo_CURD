import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject{
  @HiveField(0)
  late String title;
  @HiveField(1)
  final bool isComplieted;

  Todo({required this.title, required this.isComplieted});
}
