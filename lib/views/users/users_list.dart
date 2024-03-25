import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/views/widgets/appbar.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Users List'),
    );
  }
}