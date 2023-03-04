import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:bally/model/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bally/screen/home.dart';
import 'package:bally/screen/register.dart';

class Register extends StatelessWidget {
   
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
             appBar: AppBar( title: Text("ลงทะเบียน"),
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
                Navigator.pushReplacement(context,MaterialPageRoute(
                  builder: (context) {
                  return Register();
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

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? name) {
                                profile.name = name!;
                              },
                              validator: RequiredValidator(
                                  errorText: "กรุณากรอก Name"),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextFormField(
                              onSaved: (String? lastname) {
                                profile.lastname = lastname!;
                              },
                              validator: RequiredValidator(
                                  errorText: "กรุณากรอก Lastname"),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Lastname',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 1, 255, 56),
                              ),
                              label: Text("ยืนยัน",
                                  style: TextStyle(fontSize: 20)),
                              // color: Colors.red
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState?.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: profile.email,
                                      password: profile.password,
                                    )
                                        .then((value) {
                                      formkey.currentState?.reset();
                                      Fluttertoast.showToast(
                                          msg:
                                              "Create a user account to complete.", 
                                          gravity: ToastGravity.TOP);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return homebally();
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
                    primary: Color.fromARGB(255, 119, 6, 163),)
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
