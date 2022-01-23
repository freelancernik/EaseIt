import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ease_it/firebase/database.dart';
import 'package:ease_it/screens/resident/maintenance/residentPOV.dart';
import 'package:ease_it/screens/resident/maintenance/secretaryPOV.dart';
import 'package:ease_it/utility/loading.dart';
import 'package:ease_it/screens/resident/resident.dart';
import 'package:ease_it/screens/security/security.dart';
import 'package:ease_it/utility/globals.dart';
import 'package:flutter/material.dart';

class Maintenance extends StatefulWidget {
  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  bool loading = true;
  String role = '';
  static Globals g = Globals();

  void getUserInfo(String uid) async {
    DocumentSnapshot snapshot = await Database().getUserDetails(uid);

    // Defining user properties globally
    g.setUid = uid;
    g.setRole = snapshot.get('role');
    g.setEmail = snapshot.get('email');
    g.setFname = snapshot.get('fname');
    g.setLname = snapshot.get('lname');
    g.setPhoneNum = snapshot.get('phoneNum');

    role = snapshot.get('role');    

    setState(() => loading = false);
  }

  // Decide which screen to show
  Widget showScreen() {
    return role == 'Secretary' ? SecretaryPOV() : ResidentPOV();
  }

  @override
  void initState() {
    getUserInfo(g.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Scaffold(body: Loading()) : showScreen();
  }
}