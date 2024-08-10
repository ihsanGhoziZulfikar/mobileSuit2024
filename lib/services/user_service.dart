// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/models/user_model.dart';

// class UserService {
//   final String baseUrl = "https://reqres.in/api/users";

//   Future<List<User>> fetchUsers(int page, {int perPage = 10}) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl?page=$page&per_page=$perPage'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<User> users =
//           (data['data'] as List).map((json) => User.fromJson(json)).toList();
//       return users;
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }
