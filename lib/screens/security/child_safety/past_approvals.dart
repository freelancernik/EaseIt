import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ease_it/firebase/database.dart';
import 'package:ease_it/utility/globals.dart';
import 'package:ease_it/utility/loading.dart';
import 'package:flutter/material.dart';

class Approval {
  String name;
  String flatNo;
  int age;
  DateTime date;

  String status;

  Approval(this.name, this.flatNo, this.age, this.date, this.status);
}

class PastApproval extends StatefulWidget {
  @override
  _PastApprovalState createState() => _PastApprovalState();
}

class _PastApprovalState extends State<PastApproval> {
  bool loading = false;
  List<String> days = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  Globals g = Globals();

  Color getColor(String status) {
    if (status == "PENDING") return Color(0xff037DD6);
    if (status == "APPROVED") return Color(0xff107154);
    return Color(0xffbb121a);
  }

  String formatValue(int num) {
    return num < 10 ? '0' + num.toString() : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database().getPastChildApproval(g.society),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else {
          return snapshot.data.docs.length > 0
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    DateTime date = ds['date'].toDate();
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          ds['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flat: ${ds['wing'].toUpperCase()}-${ds['flatNo']}  Age: ${ds['age']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[500]),
                            ),
                            Text(
                              "Time: ${formatValue(date.hour)}:${formatValue(date.minute)}, ${date.day} ${days[date.month - 1]} ${date.year}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[500]),
                            )
                          ],
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: getColor(ds['status'].toUpperCase())
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(
                            ds['status'].toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: getColor(ds['status'].toUpperCase()),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/no_data.png',
                        width: 300,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No Recent Approvals',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                );
        }
      },
    );
  }
}
