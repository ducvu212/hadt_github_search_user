import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: User(),
    );
  }
}

class User extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UserState();
  }
}

class _UserState extends State<User> {

  String query = "";
  TextEditingController controller = TextEditingController();
  void searchUser(){
    setState(() {
      query = controller.text;
    });
  }

  fetchData() async {
    var url;
    url = await http.get(
        Uri.parse("https://api.github.com/search/users?q="+query));
    return json.decode(url.body)['items'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:
        TextField(
          controller: controller,
          decoration: const InputDecoration(
              hintText: 'Search User'
          ),
        ),
        actions: [
          Builder(builder: (context) => IconButton(
              onPressed: (){
                searchUser();
              },
              icon: const Icon(Icons.search)
          ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(
                              snapshot.data[index]['avatar_url']),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Login : ${snapshot.data[index]["login"]}",
                                style: TextStyle(color: Colors.black38),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Type : ${snapshot.data[index]["type"]}",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: Text('Nhap thong tin tim kiem'),
            );
          }),
    );
  }
}
