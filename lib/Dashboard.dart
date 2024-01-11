import 'package:flutter/material.dart';

import 'customer_homepage.dart';
import 'items_rozarPay_api/item_homePage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),

      body: Center(
         child: Column(
           children: [
             ElevatedButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerHomePage()));
                 } ,
                 child: Text("Customer Rozarpay api")),

             ElevatedButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemHomePage()));
                 } ,
                 child: Text("Items Rozarpay api")),

           ],
         ),
      ),

    );
  }
}
