import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostType {
  final String id;
  String title;
  PostType({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory PostType.fromMap(Map<String, dynamic> map) {
    return PostType(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostType.fromJson(String source) => PostType.fromMap(json.decode(source) as Map<String, dynamic>);
}

