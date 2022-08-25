import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/buy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hero_dialog_route.dart';



class Purchase extends StatefulWidget {


  @override
  _PurchaseState createState() {
    return _PurchaseState();
  }
}

class _PurchaseState extends State<Purchase> {
  Completer<GoogleMapController> _controller = Completer();




  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final Key _mapKey = UniqueKey();
  String _mapStyle;
  double lt = 51.5321;
  double lg = -0.4727;
  BitmapDescriptor HomeIcon;
  BitmapDescriptor myIcon;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  String seller_username=" ";
  String seller_location=" ";
  String seller_status=" ";
  String seller_gps=" ";
  String seller_price=" ";
  String seller_power=" ";
  String seller_email=" ";
  Set<Marker> _markers = {};
  String username_="";
  String purchase_successful="0";
  String value;
  String power;
  _PurchaseState();

  launchcommand(command) async {
    await launch(command);
  }



  Future<void> previous() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'sn';
    final value_username = prefs.getString(key1) ?? 0;
    setState(() {
      username_ = "$value_username";
    });


  }



  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }




  void initState() {
    previous();
    _getCurrentLocation();
    super.initState();
    setCustomMapPin();

  }

  void setCustomMapPin() async {
    myIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/seller.png'
    );
    HomeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/home.png'
    );
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
  Widget build(BuildContext context){

    return  Scaffold(

        body: Container(
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
           color: Colors.blueGrey.withOpacity(0.3),
          ),
          child: Column(
            children: [
              SizedBox(
                  height:70
              ),
              Container(

                height:MediaQuery.of(context).size.height/1.8,
                width:MediaQuery.of(context).size.width/1.05,

                color: Colors.white,
                child:Padding(padding:  EdgeInsets.all(5),
                  child: Container(color: Colors.white,
                    child: GoogleMap(
                      markers:_markers,
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lt,lg),
                        zoom: 16.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        if (mounted) {
                          setState(() {
                          _markers.add(
                              Marker(
                                  markerId: MarkerId("Home"),
                                  position: LatLng(lt,lg),
                                  icon: HomeIcon
                              ),

                          );
                          _markers.add(
                            Marker(
                                markerId: MarkerId("Mohammed"),
                                position: LatLng(lt+0.001,lg-0.002),
                                icon: myIcon,
                                onTap:() {
                                  update_seller("Mohammed");
                                  print("uoo");
                                }
                            ),

                          );
                          _markers.add(
                            Marker(
                                markerId: MarkerId("Meng"),
                                position: LatLng(lt+0.0003,lg+0.0015),
                                icon: myIcon,
                                onTap:() {
                                  update_seller("Meng");
                                }
                            ),

                          );
                        });
                        }
                      },


                    ),

                  ),),
              ),

              Container(

                height:MediaQuery.of(context).size.height/4.1,
                width:MediaQuery.of(context).size.width/1.05,
                child: Padding(padding: EdgeInsets.only( top:10, bottom: 10),
                  child: Card(
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

                                      StreamBuilder(
                                        stream: _username(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("username:         loading....",
                                            );
                                          }
                                          return Text("username:         ${snapshot.requireData}",
                                            );
                                        },
                                      ),
                                      StreamBuilder(
                                        stream: _location(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("location:            loading....",
                                            );
                                          }
                                          return Text("location:            ${snapshot.requireData}",
                                          );
                                        },
                                      ),
                                      StreamBuilder(
                                        stream: _price(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("price/kWh:        loading...");

                                          }
                                          return Text("price/kWh:        £${snapshot.requireData}.00");

                                        },
                                      ),

                                      StreamBuilder(
                                        stream: _gps(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("gps:                   loading...");

                                          }
                                          return Text("gps:                   ${snapshot.requireData}");

                                        },
                                      ),
                                      StreamBuilder(
                                        stream: _power(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("max pwr sup:    loading...");

                                          }
                                          return Text("max pwr sup:    ${snapshot.requireData}");

                                        },
                                      ),
                                      StreamBuilder(
                                        stream: _status(),
                                        builder: (context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Text("status:               loading...");

                                          }
                                          return Text("status:               ${snapshot.requireData}");

                                        },
                                      ),


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
                                          return buy(value: seller_username, price: seller_price, location: seller_location,);
                                        }));

                                      });
                                    }, child: Text("Buy")),
                                  ),
                                  SizedBox(width: 8,),

                                  Container(
                                    width:MediaQuery.of(context).size.width/2.5,
                                    child:  ElevatedButton(onPressed:(){
                                      if (mounted) {
                                        setState(() {
                                        launchcommand( 'mailto:$seller_email?subject=${Uri
                                            .encodeFull('Transaction Enquiry')}&body=${Uri.encodeFull(
                                            'Hi there, '
                                                '\n Good day! My username is $username_ and I will like to enquire about... ')}');

                                      });
                                      }
                                    }, child: Text("Send Email")),
                                  ),

                                ],),

                            ],
                          )
                      )



                  ),
                ),
              ),

            ],
          ),

        ));
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
  Stream<String> _gps() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$seller_gps";
    }
  }
  Stream<String> _status() async* {
    // This loop will run forever because _running is always true
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      // This will be displayed on the screen as current time
      yield "$seller_status";
    }
  }


  void update_seller(username) async {
    print(username);
    final querySnapshot = await FirebaseFirestore.instance.collection("sellers").where("username",isEqualTo: username).get();

    for (var doc in querySnapshot.docs) {
      final messageUsername = doc.get('username');
      final messageLocation = doc.get('location');
      final messageGps = doc.get('gps');
      final messagePrice = doc.get('price');
      final messagePower = doc.get('max power');
      final messageStatus = doc.get('status');
      final messageEmail = doc.get('email');
      print(messageStatus);


      if (mounted) {
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
  }



}
