import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user_repository.dart';
import 'models/user_model.dart';
import 'navbar.dart';
import 'home.dart';


class Register extends StatelessWidget {

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? age;
  String? email;
  String? name;
  String? soshospital;
  String? soshospitalnumber;
  String? sosnumber;

  @override
  Widget build(BuildContext context) {

    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 95, 178, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 60,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                     Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            age = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'Age',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            soshospital = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'SOS Hospital',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            soshospitalnumber = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'SOS Hospital Number',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 10),
                        child: TextField(
                          onChanged: (value) {
                            sosnumber = value;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            labelText: 'SOS Number',
                            labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                ElevatedButton(
                  onPressed: () async {
                    await users.add(
                      {
                        'userId': userId,
                        'age': age,
                        'email': email,
                        'name': name,
                        'soshospital': soshospital,
                        'soshospitalnumber': soshospitalnumber,
                        'sosnumber': sosnumber,
                      }
                    ).then((value)=> Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        ));
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}