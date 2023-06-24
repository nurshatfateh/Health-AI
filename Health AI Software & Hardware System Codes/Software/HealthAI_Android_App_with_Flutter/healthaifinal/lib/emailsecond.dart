import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:flutter/material.dart';
import 'package:healthai/Register.dart';
import 'package:healthai/services/auth.dart';
import 'email_conformation.dart';
import 'main.dart';
import 'models/loginuser.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class emailsecond extends StatefulWidget {
  @override
  State<emailsecond> createState() => _emailsecondState();
}

class _emailsecondState extends State<emailsecond> {
  @override
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final email = FirebaseAuth.instance.currentUser!.email;

  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 95, 178, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        children: [
                          Image.asset('images/mail.png'),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,

                        margin:EdgeInsets.all(15.0),

                        child:
                        ElevatedButton(
                            child: const Text('I agree to share user data' , style: TextStyle(color: Colors.white ,fontSize:20, ),),
                            onPressed: () async {
                              if(user!.emailVerified)
                              {SharedPreferences pref =await SharedPreferences.getInstance();
                              pref.setString("email", "useremail@gmail.com");
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Register()));}


                            },
                            style: ButtonStyle(

                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        side: BorderSide(color: Colors.white)

                                    )
                                )
                            )
                        )
                      // new InkWell(
                      //   onTap: () => Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(builder: (context) =>  MaterialApp(
                      //       debugShowCheckedModeBanner: false,
                      //       home: Scaffold(
                      //           backgroundColor: Color(0xFF5FB2FF),
                      //           body: Register()),
                      //
                      //     ),
                      //     ),
                      //   ),
                      //
                      //   //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                      //   child: Center(
                      //
                      //     child: ListTile(
                      //
                      //       title: Text("Press here after confirming your account from your email",
                      //         style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold, ),textAlign: TextAlign.center,
                      //       ),
                      //       contentPadding: EdgeInsets.all(15.0),
                      //     ),
                      //   ),
                      //
                      //
                      // )






                    )


                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
