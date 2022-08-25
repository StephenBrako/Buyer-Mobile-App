import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/base_screen.dart';
import 'package:untitled1/profile.dart';


class update extends StatefulWidget {
  @override
  _updateState createState() => _updateState();
}

class _updateState extends State<update> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  double lt = 51.5321;
  double lg = -0.4727;
  double width = 0.0;
  double height = 0.0;
  int _state1 = 0;
  TextEditingController username = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController meter = TextEditingController();
  TextEditingController mobile = TextEditingController();
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  ScrollController scrollController;

  void initState() {
    _getCurrentLocation();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();



  }
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        lt= position.latitude;
        lg= position.longitude;
      });


    }).catchError((e) {
      print(e);
    });
  }



  @override
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
          'Update Profile',
          style: TextStyle(color: Colors.amber),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0.0,


        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Column(



                  children:[
                    Container(
                      height: height/2.2,
                      color: Colors.blueGrey,
                      padding: EdgeInsets.only(top: 10.0,),


                      child: ListView(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: <Widget>[

                                  Column(children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: username,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input username",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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
                                    SizedBox(height: height/90,),

                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: location,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input Location",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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
                                    SizedBox(height: height/90,),

                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: postcode,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input postcode",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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
                                    SizedBox(height: height/90,),

                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: meter,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input meter id",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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
                                    SizedBox(height: height/90,),


                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: email,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input email",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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

                                    SizedBox(height: height/90,),

                                    Padding(padding: EdgeInsets.only(top: 5.0, right:10, bottom: 5.0),
                                      child:Container(
                                        height: height/20,
                                        width: width/1.1,
                                        child: TextField(
                                          controller: mobile,
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',

                                          ),

                                          onChanged: (value) {
                                            debugPrint('Something changed in Description Text Field');


                                          },
                                          decoration: InputDecoration(
                                              hintText: "input mobile number",
                                              labelStyle: TextStyle(
                                                color: Colors.black,
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
                                    SizedBox(height: height/90,),




                                  ]

                                  ),



                                ],
                              )

                          ),

                          SizedBox(height: height/40,),
                          //nhis




                        ],
                      ),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height/20,
                          width: width/1.5,


                          child: RaisedButton(
                            elevation: 5.0,

                            onPressed: () {

                              animateButton7();
                              save();


                            },


                            padding: EdgeInsets.all(3.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0XFF203354),
                            child: setUpButtonChild4(),
                          ),

                        ),
                        SizedBox(
                          height: 10,
                        ),


                      ],

                    )
                  ]






              ),








            ],
          ),
        ),


      ),
    );
  }


  Future<void> save() async {
    animateButton8();

    DateTime date = DateTime.now();
    if (location.text!=""&& postcode.text!=""
        && username.text!=""&& mobile.text!=""&& email.text!=""&& meter.text!=""){
      FirebaseFirestore.instance.collection("buyers").doc(meter.text).update({
        "location" : location.text,
        "postcode" : postcode.text,
        "username" : username.text,
        "email" : email.text,
        "gps":"$lt, $lg",
        "mobile": mobile.text,
        "meterid":meter.text,
        "username_exist":"true",
        //"account_created_date":"${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}.${date.second}",
        "last_updated":"${date.year}-${date.month}-${date.day}_${date.hour}:${date.minute}.${date.second}",
      });
      final prefs = await SharedPreferences.getInstance();
      final key11 = 'username';
      final key22 = "meterid";

      prefs.setString(key11, username.text);
      prefs.setString(key22, meter.text);

      movetomain();
    }
    else{
      animateButton8();
      _showAlertDialog('Empty Slot', "Kindly fill in every detail, type 'n/a' if not applicable");
    }


  }


  void movetomain() {
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => BaseScreen()),(route) => false);

      });});}

  void _showAlertDialog(String title, String message) {

    var alertStyle = AlertStyle(
      overlayColor: Colors.black87,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.blue,
        ),
      ),
      titleStyle: TextStyle( fontSize: 22,fontWeight: FontWeight.w700,
          color: Colors.red
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }



  Widget setUpButtonChild4() {
    if (_state1 == 0) {
      return new Text(
        'SAVE PROFILE DETAILS',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );
    } else if (_state1 == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton8() {
    setState(() {
      _state1 = 0;
    });
  }
  void animateButton7() {
    setState(() {
      _state1 = 1;
    });
  }

}
