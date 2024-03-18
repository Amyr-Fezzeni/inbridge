// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:inbridge/models/enum_classes.dart';



class UserModel {
  final String id;
  String firstName;
  String lastName;
  int cin;
  String alias;
  String email;
  String phoneNumber;
  DateTime birthday;
  Gender gender;
  Role role;
  String password;
  String adress;
  String university;
  String grade;
  UserStatus status;
  
  String getFullName() =>
      '${firstName[0]}${firstName.substring(1)} ${lastName[0]}${lastName.substring(1)}';
}

