
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Car.dart';


class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Search();
  }

}
class _Search extends State<Search> {


  List<Car> l2 = null;
  List<Car> lf = null;
  List<Car> or = null;
  int len=1;

  Future<void> getList() async{
    String url="https://myserver1107.herokuapp.com/test/getCars";
    var res= await http.get(Uri.parse(url));
    List l=json.decode(res.body);
    List<Car> r = l.map((e) => Car.fromJson(e)).toList();
    setState(() {
      l2=r;
      or=r;
      len=l2.length;
    });
  }

  @override
  void initState()  {
     getList();
    super.initState();
  }

  @override
  Widget build(BuildContext Context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 100),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                title: Text("Search"),
                expandedHeight: 200,
                backgroundColor: Colors.red,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "https://tesla-cdn.thron.com/delivery/public/image/tesla/32e5e0f3-5c04-42ef-8f8f-c6b1c26f8a9e/bvlatuR/std/2880x1800/ms-main-hero-desktop",
                    fit: BoxFit.cover,
                  ),
                )
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
               margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
               child: TextField(
                 decoration: InputDecoration(
                   hintText: "Search",
                   hoverColor: Colors.red
                 ),
                onChanged: (value)=>{
                   filter(value)
                },
               ),
            )
            ),

            getGrid()

          ],
        )
    );
  }

  void filter(String value){
      if(or!=null){
        setState(() {
          lf=or.where((car) => (car.name.toLowerCase().startsWith(value.toLowerCase()) || car.company.startsWith(value.toLowerCase()))).toList();
          l2=lf;
          print(or[0].company);
          print(or.where((car) => car.name.toLowerCase()==value.toLowerCase() || car.company.toLowerCase()==value.toLowerCase()).toList());
          print(lf);
        });

      }
      if(value.length==0 && or!=null){
        setState(() {
          l2=or;
        });
      }
  }
  Widget getGrid(){
    if(l2!=null) {
      return SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children:
          List.generate(l2.length, (i) {
            return InkWell(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blueAccent,
                child: Image.network(l2[i].link, fit: BoxFit.fill),
              ),
              onTap: ()=>{
                   showDialog(context, l2[i])
               },
            );
          })
      );
    }
    else{
      return  SliverToBoxAdapter(
          child:Center(
        child: Text("Loading",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ));
    }
    }
   void showDialog(BuildContext context,Car c){
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        builder: (context){
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(
                 height: 200,
                 child: Image.network(c.link,fit: BoxFit.cover,),
               ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Center(
                      child: Text(c.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent
                          )
                      ),
                    ),
                  ),
                  ListTile(
                    hoverColor: Colors.black26,
                    title: Text(c.cost+" /hr"),
                    leading: Icon(Icons.car_rental),
                  ),
                  ListTile(
                    hoverColor: Colors.black26,
                    title: Text(c.mileage+" KMPH"),
                    leading: Icon(Icons.miscellaneous_services_sharp),
                  )
                ],
              ),
             ],
         );
        }
    );
   }
}
