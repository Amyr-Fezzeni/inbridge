// ignore_for_file: public_member_api_docs, sort_constructors_first
class Project {
  final String id;
  String title;
  String description;
  DateTime dateCreated;
  String taskId;
  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.taskId,
  });
}
