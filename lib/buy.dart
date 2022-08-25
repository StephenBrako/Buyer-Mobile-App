import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Purchase.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';


/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class buy extends StatefulWidget {
  final String value;
  final String price;
  final String location;
  buy({Key key,this.value,this.price, this.location}):super(key: key);



  @override
  State<StatefulWidget> createState() {
    return buyState(this.value,this.price, this.location);
  }
}

class buyState extends State<buy> {
  TextEditingController t2 = TextEditingController();
  TextEditingController sn = TextEditingController();
  TextEditingController t1 = TextEditingController();
  String _sn = "";
  String _t1 = "";
  String _t2 = "";
  String value;
  String seller_username=" ";
  String seller_location=" ";
  String seller_status=" ";
  String seller_gps=" ";
  String seller_price=" ";
  String seller_power=" ";
  String seller_email=" ";
  String calculation1=" ";
  double amount_purchased=0;
  double power_purchased=0;
  String username;
  String price;
  String location;
  String meterid;


  buyState(this.value,this.price, this.location);

  void initState(){
    previous();
    update_seller();
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
    });
  }




  @override
  Widget build(BuildContext context) {
    sn.text=_sn;
    t1.text=_t1;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color:  Colors.blue.withOpacity(0.9),
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {

                      },
                      child: Text('Purchase Electricity', style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    ),

                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                      child:Container(
                        height: 50,
                        child: TextField(
                          controller: sn,
                          toolbarOptions: ToolbarOptions(
                            paste: true,
                            cut: true,
                            copy: true,
                            selectAll: true,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',

                          ),

                          onChanged: (value) {
                            debugPrint('Something changed in Description Text Field');
                            t1.text="";

                            Timer(Duration(seconds: 3), () {
                              calculate_amount(value);
                              calculation1 = "£$value will give you $power_purchased kW of power";
                            });



                          },
                          decoration: InputDecoration(
                              hintText: "enter amount",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),

                      ),),
                    SizedBox(height:5,),
                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                      child:Container(
                        height: 50,
                        child: TextField(
                          controller: t1,
                          toolbarOptions: ToolbarOptions(
                            paste: true,
                            cut: true,
                            copy: true,
                            selectAll: true,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',

                          ),

                          onChanged: (value) {
                            debugPrint('Something changed in Description Text Field');
                            sn.text="";

                            Timer(Duration(seconds: 2), () {
                              calculate_price(value);
                              calculation1 = "$value kW of power will cost you £$amount_purchased";
                            });



                          },
                          decoration: InputDecoration(
                              hintText: "enter kW to purchase",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),

                      ),),
                    SizedBox(height:5,),
                    Row(
                      children: [
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("seller:",style: TextStyle(
                              color: Colors.white,)),
                            Text("location:",style: TextStyle(
                              color: Colors.white,)),
                            Text("price/kWh:",style: TextStyle(
                              color: Colors.white,))


                          ],
                        ),
                        SizedBox(width:5,),
                        Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            StreamBuilder(
                              stream: _username(),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("loading....",style: TextStyle(
                                    color: Colors.white,)
                                  );
                                }
                                return Text("${snapshot.requireData}",style: TextStyle(
                                  color: Colors.white,)
                                );
                              },
                            ),
                            StreamBuilder(
                              stream: _location(),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("loading....",style: TextStyle(
                                    color: Colors.white,)
                                  );
                                }
                                return Text("${snapshot.requireData}",style: TextStyle(
                                  color: Colors.white,)
                                );
                              },
                            ),
                            StreamBuilder(
                              stream: _price(),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("loading...",style: TextStyle(
                                    color: Colors.white,));

                                }
                                return Text("${snapshot.requireData}",style: TextStyle(
                                  color: Colors.white,));

                              },
                            ),



                          ],
                        ),

                      ],
                    ),
                    SizedBox(height:5,),
                    Text(calculation1,style: TextStyle(
                      color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)),



                    SizedBox(height:5,),



                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    FlatButton(
                      onPressed: () {
                        _buy(amount_purchased,power_purchased);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Buy', style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
      yield "$seller_username";
    }
  }

  Stream<String> _location() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$seller_location";
    }
  }
  Stream<String> _power() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$seller_power";
    }
  }
  Stream<String> _price() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$seller_price";
    }
  }

  void update_seller() async {
    final querySnapshot = await FirebaseFirestore.instance.collection("sellers").where("username",isEqualTo: widget.value).get();

    for (var doc in querySnapshot.docs) {
      final messageUsername = doc.get('username');
      final messageLocation = doc.get('location');
      final messageGps = doc.get('gps');
      final messagePrice = doc.get('price');
      final messagePower = doc.get('max power');
      final messageStatus = doc.get('status');
      final messageEmail = doc.get('email');
      print(messageStatus);


      setState(() {
        seller_username = messageUsername;
        seller_location = messageLocation;
        seller_gps =messageGps;
        seller_price = messagePrice;
        seller_power = messagePower;
        seller_status =messageStatus;
        seller_email = messageEmail;
      });
    }
  }

  void calculate_price(value){
    var value1 = double.parse(value);
    var sellerprice = double.parse(seller_price);
    setState(() {
      amount_purchased = sellerprice * value1;
      power_purchased = value1;
    });



  }
  void calculate_amount(value){
    var value1 = double.parse(value);
    var sellerprice = double.parse(seller_price);
    setState(() {
      power_purchased = value1/sellerprice;
      amount_purchased = value1;
    });


  }
  Future<void> _buy(amount_purchased,power_purchased) async {
    print("$amount_purchased");
    print("$power_purchased");
    DateTime date = DateTime.now();

    if (power_purchased != 0 && amount_purchased != 0) {
      FirebaseFirestore.instance
          .collection('buyers')
          .where("meterid",isEqualTo: meterid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection('buyers').doc(element.id).update({
            "amount_purchased": "$amount_purchased",
            "power_purchased": "$power_purchased",
          });
          print("id: ${element.id}");
        });
      });


      FirebaseFirestore.instance.collection("history").doc("${date.year}-${date.month}-${date.day}_${date.hour}:${date
          .minute}.${date.second}").set({
        "amount_purchased": "$amount_purchased",
        "power_purchased": "$power_purchased",
        "location": widget.location,
        "username": username,
        "price": widget.price,
        "seller": widget.value,
        "date_time": "${date.year}-${date.month}-${date.day}_${date.hour}:${date
            .minute}.${date.second}",
      });


      Navigator.of(context).pop();

    }

/*
  void _buy() {
    int payment_amount =amount_purchased.round();// i = 20
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_c2ca4c0d1be9f582bfda139693737739ed1ed29a")
        ..setCompanyAssetImage(Image.asset(
            "assets/user.png"),

        )
        ..setAmount(payment_amount)
        ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
        ..setCurrency("£")
        ..setEmail("baslab.englebert@gmail.com")
        ..setFirstName("")
        ..setLastName("${widget.value}")
        ..setMetadata(
          {
            "custom_fields": [
              {
                "value": "Baslab",
                "display_name": "Payment_to",
                "variable_name": "Payment_to"
              }
            ]
          },
        )
        ..onSuccesful(_onPaymentSuccessful)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  void _onPaymentSuccessful() {


    var alertStyle = AlertStyle(
      overlayColor: Colors.black87,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle( fontSize: 18,
        color: Color.fromRGBO(0, 255, 0, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Payment Successful",
      desc: "$power_purchased kW of power successfully purchased.Payment will be reflected in your history ",
      buttons: [
        DialogButton(
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 20),
          ),
          onPressed: () {
            setState(() {

              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => Purchase(),
                  transitionDuration: Duration(seconds: 0),
                ),);

            });
          },
          color: Color.fromRGBO(91, 55, 185, 1.0),
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();

  }
*/


  }}
