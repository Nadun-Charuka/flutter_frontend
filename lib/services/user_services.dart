import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:5000/api/users';

class UserServices {
//create user
  Future<void> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(user.toJson()),
      );
      if (response.statusCode != 200) {
        debugPrint('Falied to create user: ${response.statusCode}');
        throw Exception('failed to create a user');
      } else {
        debugPrint('user created');
      }
    } catch (e) {
      debugPrint('Error creating user: $e');
    }
  }
}
