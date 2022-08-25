import 'package:flutter/material.dart';
import 'package:untitled1/update.dart';
import 'package:untitled1/constants/color_constants.dart';
import 'package:untitled1/Home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled1/profile.dart';
import 'package:untitled1/Purchase.dart';



class BaseScreen extends StatefulWidget {
  const BaseScreen({Key key}) : super(key: key);


  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    home(),
    Purchase(),
    profilepage(),




  ];
  @override

  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
              ),label: "home"

            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.list),label: "purchase"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user),label: "profile")
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
