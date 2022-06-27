import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String id;
  final String email;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.name,
  });

  factory User.createUser(Map<String, dynamic> objectJson) {
    return User(
      id: objectJson["id"].toString(),
      email: objectJson["email"],
      name: objectJson["first_name"] + " " + objectJson["last_name"],
    );
  }

  static Future<User> connectToApi(String id) async {
    Uri apiUrl = Uri.parse("https://reqres.in/api/users/" + id);

    var apiResult = await http.get(apiUrl);
    var jsonResult = json.decode(apiResult.body);
    var userData = jsonResult["data"];

    return User.createUser(userData);
  }
}
