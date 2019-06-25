import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        backgroundColor: Colors.blue,
        title: new Text('کتابخانه'),
      ),
      body: Booklist (),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('سید حسن حسینی رباط'),
              accountEmail: Text('09** *** ****'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: new Text('H'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('new group'),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('New Channel'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text('profile'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/Profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('setting'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('share'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Booklist extends StatefulWidget {
  @override
  _BooklistState createState() => _BooklistState();
}

class _BooklistState extends State<Booklist> {

  Future<List<Book>> _getBook() async{
    var data = await http.get("http://api.myjson.com/bins/jb58f");
    var jsonData = json.decode(data.body);

    List<Book> Books=[];
    for(var B in jsonData){
      Book book = Book(B["bookname"],B["bookurl"]);
      Books.add(book);
    }
    print(Books.length);

    return Books;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getBook(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context , int index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return WebviewScaffold(url: snapshot.data[index].linkBook);
                }));
              },
              child: ListTile(
                title: Text(snapshot.data[index].nameBook),
              ),
            );
          },
        );
      },
    );
  }

}

class Book{
  String nameBook;
  String linkBook;
  Book(
      this.nameBook,
      this.linkBook
      );
}
