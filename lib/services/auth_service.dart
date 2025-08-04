import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_diversition/models/user_model.dart';

class AuthService {
  static const String _baseUrl =
      'https://681839f15a4b07b9d1ce474a.mockapi.io/users';

  Future<User> registerUser(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': user.username,
        'password': user.password,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'profile_image': user.profileImage,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register user: ${response.statusCode}');
    }
  }

  Future<User?> loginUser(String username, String password) async {
    final response = await http.get(Uri.parse('$_baseUrl?username=$username'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      if (body.isNotEmpty) {
        User foundUser = User.fromJson(body[0]);
        if (foundUser.password == password) {
          return foundUser;
        }
      }
      return null;
    } else {
      throw Exception(
        // 'Failed to fetch users for login: ${response.statusCode}',
        'Invalid username or password.',
      );
    }
  }
}
