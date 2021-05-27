import 'dart:html';

import 'package:flutter/material.dart';

import 'Drawer.dart';

class Page extends StatefulWidget{
  String url;

  page(String url){
    this.url=url;
  }
  
  @override
  State<StatefulWidget> createState() {
     return _page(url);
  }
  
}

class _page extends State<Page>{

  String url;
  _page(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33,33, 33,100),
      appBar: AppBar(
        title: Text("Youtube"),
        backgroundColor: Color.fromRGBO(255, 0, 0, 99.0),
      ),
      drawer: drawer(),
      body: Container(
          child:Image.network(url)
      ),

    );
  }
  

}