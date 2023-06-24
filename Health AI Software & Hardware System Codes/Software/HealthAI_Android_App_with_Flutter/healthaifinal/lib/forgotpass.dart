import 'package:flutter/material.dart';
import 'email_conformation.dart';
import 'home.dart';

class forgotpass extends StatelessWidget {
  @override
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
                    SizedBox(
                      height: 200,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [

                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: ElevatedButton(
                            child: Text('Send Recovery email',style: TextStyle(color: Colors.white ,fontSize:20, ),),
                            onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => emailpass()),
                              );
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        side: BorderSide(color: Colors.white)
                                    )
                                )
                            )
                        )
                    ),
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



class emailpass extends StatelessWidget {
  @override
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
                      child: new InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => newpass()),
                        ),

                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: Center(

                          child: ListTile(

                            title: Text("Press here after confirming your account from your email",
                              style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold, ),textAlign: TextAlign.center,
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),


                      ),)


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


class newpass extends StatelessWidget {
  @override
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
                    SizedBox(height: 200.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              'Change Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40),textAlign: TextAlign.center,
                            )),

                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [

                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                labelText: 'New Password',
                                labelStyle: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w900),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w900),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                            ),
                          ),
                          Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: ElevatedButton(
                                  child: Text('Login',style: TextStyle(color: Colors.white ,fontSize:20, ),),
                                  onPressed: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => BaseApp()),
                                    );
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                              side: BorderSide(color: Colors.white)
                                          )
                                      )
                                  )
                              )
                          ),
                        ],
                      ),
                    ),

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

