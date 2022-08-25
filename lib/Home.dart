
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/util/button.dart';





class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _controller = PageController(initialPage: 0);
  String Location_;
  final bool _running = true;
  double progress = 0.5;
  final fb = FirebaseDatabase.instance;
  String username="";
  String meterid="";

  String buyer_username=" ";
  String buyer_location=" ";
  String buyer_status=" ";
  String buyer_gps=" ";
  String buyer_meterid=" ";
  String buyer_power=" ";
  String buyer_amount=" ";
  double pwr_sec=0.0;
  double pwr_prev=0.0;
  double amount_remaining=0.0;
  double power_consumed_total=0.0;
  String buyer_power_consumed="";
  String buyer_amount_remaining="";
  double buy_amount1=0;
  double buy_amount2=0;
  double buy_amt=0;


  void initState() {
    previous();

    super.initState();

  }

  Future<void> previous() async {
    final prefs = await SharedPreferences.getInstance();
    final key11 = 'username';
    final key22 = 'meterid';
    final value_username = prefs.getString(key11) ?? 0;
    final value_meterid = prefs.getString(key22) ?? 0;
    setState(() {
      username = value_username;
      meterid = value_meterid;
      print("$value_meterid");
      update_buyer(value_meterid);


    });



  }

  @override
  Widget build(BuildContext context) {
    final refcurrent=fb.reference().child("$meterid/current");
    final refvoltage=fb.reference().child("$meterid/voltage");
    final refpower=fb.reference().child("$meterid/power");
    final refenergy=fb.reference().child("$meterid/energy");
    final refamountremaining=fb.reference().child("FIRST STAR ACADEMY/ALLSTUDENTS/100017/NAME");
    final refamountspent=fb.reference().child("FIRST STAR ACADEMY/ALLSTUDENTS/100017/NAME");

    return Scaffold(

      body: Container(
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1c3545),
              Color(0xFF192f3e),
              Color(0xFF162936),
              Color(0xFF13232e),
              Color(0xFF101e27),
              Color(0xFF0c181f),
              Color(0xFF060c0f),
            ],
            stops: [0.22, 0.25,0.265, 0.275, 0.29,0.319, 9 ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height:70
            ),
            Container(
              padding: EdgeInsets.all(5),
              height:MediaQuery.of(context).size.height/1.3,
              width:MediaQuery.of(context).size.width/1.05,

              color: Colors.white.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Center(child:  Text("Power Usage", style: TextStyle(color: Colors.white,fontSize: 32),),),
                  SizedBox(
                    height: 10,
                  ),
                 Row(crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       width: 220,
                       height: 220,
                       child: Stack(
                         fit: StackFit.expand,
                         children: [
                           CircularProgressIndicator(
                             value: progress,
                             valueColor: AlwaysStoppedAnimation(Colors.green),
                             strokeWidth: 12,
                             backgroundColor: Colors.white,
                           ),
                           Center(child: buildProgress()),
                         ],
                       ),
                     ),
                   ],
                 ),
                  SizedBox(
                    height: 50,
                  ),
                 Row(
                   children: [
                     Column(   mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(" Username :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" Location :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" GPS :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" Energy :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" Power :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" Power Consumed :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),
                         Text(" Total Power Bought :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),Text(" Total Amount Bought :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),
                         Text(" Amount Remaining :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),
                         Text(" Current :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),
                         Text(" Voltage :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),
                         Text(" Meter ID :  ",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),
                         SizedBox(
                           height: 10,
                         ),



                       ],
                     ),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(buyer_username,
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text("$buyer_location",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                         ),


                         SizedBox(
                           height: 10,
                         ),
                         Text("$buyer_gps",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),),





                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                             stream: refenergy.onValue,
                             builder: (context, snap) {
                               if (snap.hasData &&
                                   !snap.hasError &&
                                   snap.data.snapshot.value != null) {
                                 var data = snap.data.snapshot.value;

                                 return Text("$data",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );
                               }else{
                                 return Text("loading....",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );}}
                         ),


                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                             stream: refpower.onValue,
                             builder: (context, snap) {
                               if (snap.hasData &&
                                   !snap.hasError &&
                                   snap.data.snapshot.value != null) {
                                 var data = snap.data.snapshot.value;
                                 power_per_sec(data);
                                 //update_buyer(meterid);

                                 Timer(Duration(seconds: 6), () {
                                   //power_per_sec(data);
                                  // update_buyer(meterid);

                                 });

                                 return Text("$data W",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );
                               }else{
                                 return Text("loading....",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );}}
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                           stream: _power_consumed(),
                           builder: (context, AsyncSnapshot<String> snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return Text("${power_consumed_total.toStringAsFixed(3)} W",
                                 style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                               );
                             }
                             return Text("${snapshot.requireData}",
                               style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                             );
                           },
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                           stream: _power_bought(),
                           builder: (context, AsyncSnapshot<String> snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return Text("$buyer_power kW",
                                 style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                               );
                             }
                             return Text("${snapshot.requireData} kW",
                               style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                             );
                           },
                         ),

                         SizedBox(
                           height: 10,
                         ),
                         Text("£$buyer_amount",
                           style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                         ),



                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                           stream: _power_consumed(),
                           builder: (context, AsyncSnapshot<String> snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               buy_amt = double.parse(buyer_amount);
                               buy_amount1= 0.01*buy_amt*power_consumed_total;
                               buy_amount2= buy_amt-buy_amount1;
                               buyer_amount_remaining = "${buy_amount2.toStringAsFixed(3)}";
                               return Text("£$buyer_amount_remaining",
                                 style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                               );
                             }
                             return Text("£$buyer_amount_remaining",
                               style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                             );
                           },
                         ),


                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                             stream: refcurrent.onValue,
                             builder: (context, snap) {
                               if (snap.hasData &&
                                   !snap.hasError &&
                                   snap.data.snapshot.value != null) {
                                 var data = snap.data.snapshot.value;

                                 return Text("$data",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );
                               }else{
                                 return Text("loading....",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );}}
                         ),

                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                             stream: refvoltage.onValue,
                             builder: (context, snap) {
                               if (snap.hasData &&
                                   !snap.hasError &&
                                   snap.data.snapshot.value != null) {
                                 var data = snap.data.snapshot.value;

                                 return Text("$data",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );
                               }else{
                                 return Text("loading....",
                                   style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),
                                 );}}
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         StreamBuilder(
                           stream: _meterid(),
                           builder: (context, AsyncSnapshot<String> snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return Text(meterid,
                                 style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),);

                             }
                             return Text("${snapshot.requireData}",
                               style: TextStyle(fontSize: 18,color:Colors.white,fontWeight: FontWeight.w300),);

                           },
                         ),

                         SizedBox(
                           height: 10,
                         ),
                       ],
                     )
                   ],
                 )

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /* Center(child:  Text("Previous Seller", style: TextStyle(color: Colors.white,fontSize: 18),),),
            SizedBox(
              height: 5,
            ),

           Container(

              height:MediaQuery.of(context).size.height/5,
              width:MediaQuery.of(context).size.width/1.05,
              child: Padding(padding: EdgeInsets.only(right:5,left: 5, top:10, bottom: 10),
                child: Card(
                    color: Colors.white,


                    child:Padding(padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 5,),
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/user.png"),
                              ),
                              SizedBox(width: 10,),
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("username:         Stephen31"),
                                  Text("location:            UB8 3FG"),
                                  Text("gps:                   1.729383, 3.392093"),
                                  Text("purchase date:  12-08-2022"),

                                ],
                              ),
                              SizedBox(width: 8,),

                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                           Container(
                             width:MediaQuery.of(context).size.width/2.5,
                             child:  ElevatedButton(onPressed:(){
                               setState(() {

                               });
                             }, child: Text("Buy")),
                           ),
                            SizedBox(width: 8,),

                            Container(
                              width:MediaQuery.of(context).size.width/2.5,
                              child:  ElevatedButton(onPressed:(){
                                setState(() {

                                });
                              }, child: Text("Send message")),
                            ),

                          ],)
                        ],
                      )
                    )



                ),
              ),
            )*/


          ],
        ),





    ));
  }

  Stream<String> _location() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_location";
    }
  }

  Widget buildProgress() {
    if (progress == 1) {
      return Icon(
        Icons.done,
        color: Colors.green,
        size: 56,
      );
    } else {
      return Text(
        '${(progress * 100).toStringAsFixed(1)}%',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24,
        ),
      );
    }
  }

  void update_buyer(meterid) async {
    print("$meterid");
    final querySnapshot = await FirebaseFirestore.instance.collection("buyers").where("meterid",isEqualTo: meterid).get();

    for (var doc in querySnapshot.docs) {
      final messageUsername = doc.get('username');
      final messageLocation = doc.get('location');
      final messageGps = doc.get('gps');
      final messageMeterid = doc.get('meterid');
      final messagePower = doc.get('power_purchased');
      final messageAmount = doc.get('amount_purchased');
      final messagePower_consumed = doc.get('power_consumed');




      if (mounted) {
        setState(() {
        buyer_username = messageUsername;
        buyer_location = messageLocation;
        buyer_gps =messageGps;
        buyer_meterid = messageMeterid;
        buyer_amount = messageAmount;
        buyer_power = messagePower;
        buyer_power_consumed = messagePower_consumed;



      });
      }
    }

  }

  Stream<String> _username() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_username";
    }
  }


  Stream<String> _meterid() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_meterid";
    }
  }


  Stream<String> _gps() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_gps";
    }
  }

  Stream<String> _power_bought() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_power";
    }
  }
  Stream<String> _amount_bought() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_amount";
    }
  }

  void power_per_sec(data){


    pwr_sec = double.parse(data);
    pwr_prev =double.parse(buyer_power_consumed);
    var total1 =pwr_sec/3600;
    power_consumed_total=total1 +pwr_prev;

    FirebaseFirestore.instance.collection('buyers').doc("transaction1").update({
      "power_consumed": "$power_consumed_total",
      "amount_remaining": "$buyer_amount_remaining"
    });
    print(meterid);



  }

  Stream<String> _power_consumed() async* {

    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "${power_consumed_total.toStringAsFixed(3)} W";
    }
  }



}
