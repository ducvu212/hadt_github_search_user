import 'package:flutter/material.dart'
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search user',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search User'),
          actions: [
            IconButton(
                onPressed:() {},
                icon: Icon(Icons.search)
            ),
          ],
        ),
        body: SafeArea(
            child: MyHomePage()
        ),
      ),
    );
  }
}
class  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Text('total'),
        ),
        Row(
          //column coot
          children: [
            Column(
              children: [
                Text('Name'),
                Text('id'),
              ],
            ),
          ],
        ),
      ],
  }
}
