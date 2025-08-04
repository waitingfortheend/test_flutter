import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_diversition/models/user_model.dart';

class UserService {
  static const String _baseUrl =
      'https://681839f15a4b07b9d1ce474a.mockapi.io/users';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<User> getUserById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return User.fromJson(body);
    } else if (response.statusCode == 404) {
      throw Exception('User with ID $id not found.');
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  Future<User> updateUser(String id, User user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('User with ID $id not found for update.');
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      // print('User with ID $id deleted successfully.');
    } else if (response.statusCode == 404) {
      throw Exception('User with ID $id not found for deletion.');
    } else {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }
}
