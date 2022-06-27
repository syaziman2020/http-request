import 'dart:convert';
import 'package:http/http.dart' as http;

class UserGroup {
  final String id;
  final String email;

  UserGroup({
    required this.id,
    required this.email,
  });

  factory UserGroup.createUser(Map<String, dynamic> objectJsn) {
    return UserGroup(
      id: objectJsn["id"].toString(),
      email: objectJsn["email"],
    );
  }
  static Future<List<UserGroup>> getUsers(String page) async {
    Uri apiUrl = Uri.parse("https://reqres.in/api/users?page=" + page);
    var apiResult = await http.get(apiUrl);
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)["data"];

    List<UserGroup> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(UserGroup.createUser(listUser[i]));
    }
    return users;
  }
}
