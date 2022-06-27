import 'package:flutter/material.dart';
import 'package:http_request/get_grouping_data.dart';
import 'package:http_request/post_result.dart';
import 'package:http_request/get_result_model.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostResult? postResult;
  User? userData;
  String singleData = "no data right now";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo req to API"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(resultData()),
              Text(resultGetData()),
              Text(singleData),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    PostResult.connectToAPI("Udin", "programmer").then((value) {
                      postResult = value;
                    });
                    setState(() {});
                  },
                  child: const Text("Post"),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    User.connectToApi("3").then((value) {
                      userData = value;
                    });
                    setState(() {});
                  },
                  child: const Text("Get"),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    UserGroup.getUsers("1").then((users) {
                      singleData = "";
                      for (int i = 0; i < (users.length / 2).toInt(); i++) {
                        singleData = singleData + "[" + users[i].email + "]";
                      }
                    });
                    setState(() {});
                  },
                  child: const Text("Get list"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String resultData() => (postResult != null)
      ? postResult!.id +
          " | " +
          postResult!.name +
          " | " +
          postResult!.job +
          " | " +
          postResult!.created
      : "no data exceed";

  String resultGetData() => (userData != null)
      ? userData!.id + " | " + userData!.email + " | " + userData!.name
      : "no data exceed on get Method";
}
