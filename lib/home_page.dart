import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 1;
  var image;

  Future<String> getImage() async {
    var resp = await http.get('https://jsonplaceholder.typicode.com/photos/$count');
    if(resp.statusCode == 200) {
      return convert.jsonDecode(resp.body)['thumbnailUrl'];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getImage().then((value)=> {
        image = value
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            count = count + 1;
            getImage().then((value) => {
              image = value
            });
          });
        },
      ),
    );
  }
}
