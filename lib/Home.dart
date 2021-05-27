import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Car.dart';
import 'Drawer.dart';


class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }

}
class _Home extends State<Home>{


  List<String> l= ["vamshi","Addanki","Sai","Vamshi"];

  @override
  void initState() {
    this.load();
    super.initState();
  }

  List<Car> l2 = null;
  int len=1;
  Future<void> load() async{
    print("started");
    String url="https://myserver1107.herokuapp.com/test/getCars";
    var res= await http.get(Uri.parse(url));
    List l=json.decode(res.body);
    List<Car> r = l.map((e) => Car.fromJson(e)).toList();
    print(l2);
    setState(() {
      l2=r;
      len=l2.length;
    });
  }



  var Scaffolfkey= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: Scaffolfkey,
            backgroundColor: Color.fromRGBO(33,33, 33,100),
            appBar: AppBar(
              title: Text("Cars"),
              backgroundColor: Color.fromRGBO(255, 0, 0, 99.0),
            ),
            body: Container(
                child:getList()
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.search),
              backgroundColor: Colors.red,
              onPressed: (){
                Navigator.pushNamed(context, '/search');

              },

            ),
      );
  }

  void Add(){
    setState(() {
      l.add("Vamshi");
    });
  }

  int check(){
      var w=MediaQuery.of(context).size.width;
      var h=MediaQuery.of(context).size.height;
      print("${w} ${h}");
      if(w>500){
        return 2;
      }
      else{
        return 1;
      }

  }

  Widget getList(){
    if(l2!=null){
    return GridView.count(
        crossAxisCount: check(),
        crossAxisSpacing: 10,
        children: List.generate(l2.length, (i) {
           return Container(
            color: Color.fromRGBO(33,33, 33,100),
            alignment: Alignment.bottomCenter,
            height: 260,
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  InkWell(
                    onTap: (){
                      showDialog(l2[i]);
                    },
                    child:  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: 200,
                      padding: EdgeInsets.zero,
                      color: Colors.blueAccent,
                      child: Image.network(l2[i].link,fit: BoxFit.cover,),
                    )
                  ),
                InkWell(
                   child: Container(
                   height: 60,
                   color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           CircleAvatar(
                                 radius: 20,
                            ),
                           Container(
                              child: Text(l2[i].name),
                             margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                             )
                          ]
                    ),
                  ),
                )
              ],
            ),
          );
        }
    )
    );
    }
    else{
      return Container(
        child: Center(
          child: Text("Loading",style: TextStyle(
            color: Colors.white
          ),),
        ),
      );
    }
  }
  void showDialog(Car car){
    Scaffolfkey.currentState.showBottomSheet(
            (context) => Container(
              child: Center(
                child: Image.network(car.link)
              ),
            )
    );
  }
}

