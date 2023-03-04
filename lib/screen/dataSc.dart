import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bally/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/profile.dart';

class dataSc extends StatelessWidget {
  dataSc({super.key});
  final auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile(
      email: ' ',
      name: ' ',
      lastname: ' ',
      password: ' ',
      
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
         leading: Icon(Icons.menu),
        title: Text('Data'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            label: Text(
              "",
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return homebally();
                }));
              });
            },style: ElevatedButton.styleFrom(
                    primary: Colors.black,)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [ Image.asset("assets/img/Item_Electroculus.png"),
              Text(
                auth.currentUser!.email!,
                style: TextStyle(fontSize: 20),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
