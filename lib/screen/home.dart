import 'package:flutter/material.dart';
import 'package:bally/screen/register.dart';
import 'package:bally/screen/login.dart';

class homebally extends StatelessWidget {
  const homebally({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title:Image.asset(
         "assets/img/Logooo.png",
         fit: BoxFit.contain,
         height: 50,
       ),
           backgroundColor: Color.fromARGB(255, 119, 6, 163),
         ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset("assets/img/Inazuma.png"),
                  Container(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          margin: EdgeInsets.all(5),
            width: double.infinity,
              child: ElevatedButton.icon(
                 icon: Icon(
                  Icons.add,
                    color: Color.fromARGB(255, 1, 255, 56),
                          ),
                  label: Text("สร้างบัญชี",
                style: TextStyle(fontSize: 20, )),
              onPressed: () {
            Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return Register();
                        }));
                        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 119, 6, 163),
                        ),
                        ),
                        ),
            Container(
              margin: EdgeInsets.all(5),
                width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.login,
                        color: Color.fromARGB(255, 1, 255, 56),
                              ),
                        label: Text("เข้าสู่ระบบ",
                      style: TextStyle(fontSize: 20, )),
                    onPressed: () {
                  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return login();
                           }));
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
    );
  }
}
