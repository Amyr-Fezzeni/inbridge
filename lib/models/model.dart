
import 'package:inbridge/models/category.dart';
import 'package:inbridge/models/post_type.dart';

class Model {
  final String id;
  String title;
  String description;
  DateTime dateCreated;
  PostType postType;
  Category category;
  bool isVisible;
  Model({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.postType,
    required this.category,
    required this.isVisible,
  });
}
