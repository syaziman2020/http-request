import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResult {
  final String id;
  final String name;
  final String job;
  final String created;

  PostResult({
    required this.id,
    required this.name,
    required this.job,
    required this.created,
  });

  factory PostResult.createPostResult(Map<String, dynamic> objectJSon) {
    return PostResult(
      id: objectJSon["id"],
      name: objectJSon["name"],
      job: objectJSon["job"],
      created: objectJSon["createdAt"],
    );
  }

  static Future<PostResult> connectToAPI(String name, String job) async {
    Uri apiUrl = Uri.parse('https://reqres.in/api/users');

    http.Response apiResult =
        await http.post(apiUrl, body: {"name": name, "job": job});
    var jsonResult = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonResult);
  }
}
