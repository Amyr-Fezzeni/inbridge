// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:inbridge/models/enum_classes.dart';
import 'package:inbridge/services/util/logic_service.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  int? cin;
  String alias;
  String photo;
  String email;
  String phoneNumber;
  DateTime birthday;
  Gender gender;
  Role role;
  String password;
  String adress;
  String university;
  String grade;
  DateTime dateCreated;
  UserStatus status;
  bool notificationStatus;
  String? fcm;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.cin,
    this.alias = '',
    this.photo = '',
    required this.email,
    this.phoneNumber = '',
    required this.birthday,
    required this.gender,
    this.role = Role.creator,
    required this.password,
    this.adress = '',
    this.university = '',
    this.grade = '',
    this.fcm,
    required this.dateCreated,
    this.notificationStatus = true,
    this.status = UserStatus.active,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'cin': cin,
      'alias': alias,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthday': birthday.millisecondsSinceEpoch,
      'gender': gender.name,
      'role': role.name,
      'password': password,
      'adress': adress,
      'university': university,
      'grade': grade,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'status': status.name,
      'fcm': fcm,
      'notificationStatus': notificationStatus
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        firstName: map['firstName'] as String,
        lastName: map['lastName'] as String,
        cin: map['cin'] as int?,
        alias: map['alias'] as String,
        email: map['email'] as String,
        dateCreated:
            DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
        phoneNumber: map['phoneNumber'] as String,
        birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
        gender: getUserGenderFromString(map['gender']),
        role: getUserRoleFromString(map['role']),
        password: map['password'] as String,
        adress: map['adress'] as String,
        university: map['university'] as String,
        grade: map['grade'] as String,
        status: getUserStatusFromString(map['status']),
        notificationStatus: map['notificationStatus'] ?? true,
        fcm: map['fcm']);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String getFullName() => "${capitalize(firstName)} ${capitalize(lastName)}";
}
