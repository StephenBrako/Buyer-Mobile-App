import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy.dart';
import 'hero_dialog_route.dart';


class history extends StatefulWidget {
  const history({Key key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  double width = 0.0;
  double height = 0.0;
  String seller_username=" ";
  String seller_location=" ";
  String seller_amountpaid=" ";
  String seller_gps=" ";
  String seller_price=" ";
  String seller_power=" ";
  ScrollController _controller;
  String username;


  void initState() {
    previous();
    super.initState();
  }
  Future<void> previous() async {
    final prefs = await SharedPreferences.getInstance();
    final key11 = 'username';
    final value_username = prefs.getString(key11) ?? 0;
    setState(() {
      username = value_username;
    });
  }


  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Purchase History',
          style: TextStyle(color: Colors.amber),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0.0,


        centerTitle: true,
      ),
      body:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Column(



                  children:[
                    Container(
                      height: height/1.2,
                      color: Colors.blueGrey,
                      padding: EdgeInsets.only(top: 10.0,),


                      child:  StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("history").where("username",isEqualTo: username).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return new Padding(padding: EdgeInsets.only( bottom: 5,top: 5),
                              child: SizedBox(

                                child:  new ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot doc = snapshot.data.docs[index];


                                    return new Card(
                                        color:Colors.white,


                                        child:Padding(padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [

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
                                                        Text("Seller:"),
                                                        Text("Location:"),
                                                        Text("Price:"),
                                                        Text("Power:"),
                                                        Text("Amount Paid:"),
                                                        Text("Date Purchased:"),



                                                      ],
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Column(mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${doc["seller"]}"),
                                                        Text("${doc["location"]}"),
                                                        Text("${doc["power_purchased"]}kW"),
                                                        Text("£${doc["price"]} per kW"),
                                                        Text("${doc["amount_purchased"]}"),
                                                        Text("${doc["date_time"]}"),


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
                                                          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                                            return buy(value: "${doc["seller"]}", price:" ${doc["price"]}", location: "${doc["location"]}",);
                                                          }));

                                                        });
                                                      }, child: Text("Buy Again")),
                                                    ),
                                                    SizedBox(width: 8,),

                                                    Container(
                                                      width:MediaQuery.of(context).size.width/2.5,
                                                      child:  ElevatedButton(onPressed:(){
                                                        setState(() {

                                                        });
                                                      }, child: Text("Send Email")),
                                                    ),

                                                  ],),

                                              ],
                                            )
                                        )

                                    );
                                  },


                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("No data"),
                            );
                          }
                        },
                      ),



          )]


              ),








            ],
          ),
        ),


      ),
    );
  }

}
