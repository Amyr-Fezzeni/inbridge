import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Report {
  final String id;
  final String userId;
  final String message;
  final String role;
  final bool seen;
  Report({
    required this.id,
    required this.userId,
    required this.message,
    required this.role,
    required this.seen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'message': message,
      'role': role,
      'seen': seen,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as String,
      userId: map['userId'] as String,
      message: map['message'] as String,
      role: map['role'] as String,
      seen: map['seen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(id: $id, userId: $userId, message: $message, role: $role, seen: $seen)';
  }
}



class UserBanReport {
  final String id;
  final DateTime dateCreated;
  final DateTime? dateReactive;
  final String reportReason;
  UserBanReport({
    required this.id,
    required this.dateCreated,
    this.dateReactive,
    required this.reportReason,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateReactive': dateReactive?.millisecondsSinceEpoch,
      'reportReason': reportReason,
    };
  }

  factory UserBanReport.fromMap(Map<String, dynamic> map) {
    return UserBanReport(
      id: map['id'] as String,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
      dateReactive: map['dateReactive'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateReactive'] as int) : null,
      reportReason: map['reportReason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBanReport.fromJson(String source) => UserBanReport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserBanReport(id: $id, dateCreated: $dateCreated, dateReactive: $dateReactive, reportReason: $reportReason)';
  }
}
