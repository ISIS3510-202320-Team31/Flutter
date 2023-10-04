import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;

  UserCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        // You can add more info here
      ),
    );
  }
}
