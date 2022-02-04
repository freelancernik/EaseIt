// Resident Landing page

import 'package:ease_it/firebase/authentication.dart';
import 'package:ease_it/screens/resident/Approval/approvalHome.dart';
import 'package:ease_it/screens/common/forum.dart';
import 'package:ease_it/screens/resident/maintenance/maintenance.dart';
import 'package:ease_it/screens/resident/residentHome.dart';
import 'package:ease_it/utility/drawer.dart';
import 'package:ease_it/utility/globals.dart';
import 'package:flutter/material.dart';

class Resident extends StatefulWidget {
  @override
  _ResidentState createState() => _ResidentState();
}

class _ResidentState extends State<Resident> {
  Globals g = Globals();
  String name;
  int _pageIndex = 0;
  List<Widget> pages = [ResidentHome(), Forum(), Approval(), Maintenance()];

  @override
  void initState() {
    name = g.fname + " " + g.lname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: showDrawer(context, g.role, g.fname + " " + g.lname),
      backgroundColor: Colors.white,
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) => setState(() => _pageIndex = value),
        selectedItemColor: Color(0xff1a73e8),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: 'Forum'),
          BottomNavigationBarItem(
              icon: Icon(Icons.security_outlined), label: 'Approvals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.build_outlined), label: 'Maintenance')
        ],
      ),
    );
  }
}
