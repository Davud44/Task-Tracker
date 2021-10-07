import 'package:flutter/material.dart';
import 'package:task_tracker/services/auth.dart';

AppBar appBar(String text) {
  AuthService authService = AuthService();

  return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            authService.signOut();
          },
        )
      ],
      title: Center(
    child: Text(text),
  ));
}
