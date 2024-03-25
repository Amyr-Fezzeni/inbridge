import 'dart:convert';
import 'package:inbridge/models/category.dart';
import 'package:inbridge/models/enum_classes.dart';
import 'package:inbridge/models/post_type.dart';

class Task {
  final String id;
  String title;
  String description;
  Category category;
  PostType postType;
  DateTime dateCreated;
  DateTime limitDate;
  TaskStatus status;
  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.postType,
      required this.dateCreated,
      required this.limitDate,
      this.status = TaskStatus.inProgress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category.toMap(),
      'postType': postType.toMap(),
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'limitDate': limitDate.millisecondsSinceEpoch,
      'status': status.name
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        category: Category.fromMap(map['category'] as Map<String, dynamic>),
        postType: PostType.fromMap(map['postType'] as Map<String, dynamic>),
        dateCreated:
            DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
        limitDate: DateTime.fromMillisecondsSinceEpoch(map['limitDate'] as int),
        status: getTaskStatusFromString(map['status']));
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
