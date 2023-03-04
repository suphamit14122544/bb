import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:bally/screen/dataSc.dart';
import '../model/profile.dart';
import 'home.dart';

class login extends StatelessWidget {
  @override
  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
get auth => FirebaseAuth.instance;
  Profile profile = Profile(
      email: ' ',
      name: ' ',
      lastname: ' ',
      password: ' '); 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar( title: Text("เข้าสู่ระบบ"),
              backgroundColor: Color.fromARGB(255, 119, 6, 163),
                 actions: [
          
          ElevatedButton.icon(
            icon: Icon(
              Icons.home,
             color: Color.fromARGB(255, 119, 6, 163),
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
            },  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 119, 6, 163),)
          ),         
        ],              
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "กรุณากรอก E-mail"),
                                EmailValidator(
                                    errorText: "รูปแบบของ E-mail ไม่ถูกต้อง")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'E-mail',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? password) {
                                profile.password = password!;
                              },
                              validator: RequiredValidator(
                                  errorText: "กรุณากรอก Password"),
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.login,
                                color: Color.fromARGB(255, 1, 255, 56),
                              ),
                              label:
                                  Text("Login", style: TextStyle(fontSize: 20)),
                              
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState?.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formkey.currentState?.reset();
                                          Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return dataSc();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "${e.message}", 
                                        gravity: ToastGravity.TOP);
                                  }
                                }            
                              },
                              style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 119, 6, 163),
                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        return Scaffold(
         body: Center(
         child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
