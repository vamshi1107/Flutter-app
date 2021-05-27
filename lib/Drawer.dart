import 'package:flutter/material.dart';

class drawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Drawer(
       child: Column(
         children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.red,
            )
         ],
       )
     );
  }

}