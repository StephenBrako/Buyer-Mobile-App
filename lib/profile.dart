import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/update.dart';

import 'history.dart';



class profilepage extends StatefulWidget {
  const profilepage({Key key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  String buyer_username=" ";
  String buyer_location = " ";
  String buyer_gps =" ";
  String buyer_postcode = " ";
  String buyer_email = " ";
  String buyer_phone =" ";
  String buyer_accountcreated=" ";
  String username="";


  void initState() {
    previous();
    super.initState();
  }
  Future<void> previous() async {
    final prefs = await SharedPreferences.getInstance();
    final key11 = 'username';
    final key22 = 'meterid';
    final value_username = prefs.getString(key11) ?? 0;
    setState(() {
      username = value_username;
      update_buyer(value_username);
    });
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(


        title: Text(
          'Profile',
          style: TextStyle(color: Colors.amber),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.post_add_sharp, color: Colors.black),
              onPressed: () =>  Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => update(),
                  transitionDuration: Duration(seconds: 0),
                ),)
          ),
        ],



        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: EdgeInsets.only(right:5,left: 5, top:10, bottom: 10),
              child: Card(
                  color: Colors.white,


                  child:Padding(padding: EdgeInsets.only(right:5,left: 15, top:5, bottom: 5),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),


                            Container(
                              color: Colors.blue,
                              height: MediaQuery.of(context).size.height/3.2,
                              width:MediaQuery.of(context).size.width/1.2,
                              child:  Image.asset("assets/user.jpg"),
                              ),


                          SizedBox(height: 20,),
                          Row(

                            children: [
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("  username:  ", style: TextStyle(fontSize: 18),),
                                  SizedBox(height: 5,),
                                  Text("  location:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  postcode:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  gps:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  email:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  phone:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  account created:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),
                                  Text("  last updated:  ", style: TextStyle(fontSize: 18)),
                                  SizedBox(height: 5,),



                                ],
                              ),
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  StreamBuilder(
                                    stream: _username(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _location(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _postcode(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _gps(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 13)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 15)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _email(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 16)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _phone(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _account_created(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  StreamBuilder(
                                    stream: _last_updated(),
                                    builder: (context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("loading....",style: TextStyle(fontSize: 18)
                                        );
                                      }
                                      return Text("${snapshot.requireData}",style: TextStyle(fontSize: 18)
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5,),




                                ],
                              ),
                            ],
                          )
                          ,
                          SizedBox(height: 10,),

                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                width:MediaQuery.of(context).size.width/1.15,

                                child:  ElevatedButton(onPressed:(){
                                  setState(() {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) => update(),
                                        transitionDuration: Duration(seconds: 0),
                                      ),);


                                  });
                                }, child: Text("Update Profile")),
                              ),
                              SizedBox(height: 5,),

                              Container(
                                width:MediaQuery.of(context).size.width/1.15,
                                child:  ElevatedButton(onPressed:(){
                                  setState(() {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) => history(),
                                        transitionDuration: Duration(seconds: 0),
                                      ),);


                                  });
                                }, child: Text("View Purchase History")),
                              ),

                            ],)
                        ],
                      )
                  )



              ),
            ),

          ],
        ),
      ),

    );
  }

  bool _running = true;
  Stream<String> _username() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_username";
    }
  }
  Stream<String> _location() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_location";
    }
  }
  Stream<String> _postcode() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_postcode";
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
  Stream<String> _email() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_email";
    }
  }
  Stream<String> _phone() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_phone";
    }
  }
  Stream<String> _account_created() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_accountcreated";
    }
  }
  Stream<String> _last_updated() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$buyer_accountcreated";
    }
  }

  void update_buyer(username) async {
    print(username);
    final querySnapshot = await FirebaseFirestore.instance.collection("buyers").where("username",isEqualTo: username).get();

    for (var doc in querySnapshot.docs) {
      final messageUsername = doc.get('username');
      final messageLocation = doc.get('location');
      final messageGps = doc.get('gps');
      final messagePostcode = doc.get('postcode');
      final messagePhone = doc.get('mobile');
      final messageEmail = doc.get('email');
      final messageAccount = doc.get('account_created_date');



      setState(() {
        buyer_username = messageUsername;
        buyer_location = messageLocation;
        buyer_gps =messageGps;
        buyer_postcode = messagePostcode;
        buyer_email = messageEmail;
        buyer_phone = messagePhone;
        buyer_accountcreated=messageAccount;
      });
    }
  }





}
