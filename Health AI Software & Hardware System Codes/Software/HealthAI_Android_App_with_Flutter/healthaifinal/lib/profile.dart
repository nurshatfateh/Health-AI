import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navbar.dart';

class userProfile extends StatefulWidget {
  final String userId;

  const userProfile({required this.userId, Key? key}) : super(key: key);

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Center(
            child: Text(
              'Health AI',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Navbar(),
      backgroundColor: Color.fromARGB(1000, 95, 178, 255),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _db.collection(_collectionName).doc(widget.userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              SizedBox(height: 50.0,),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: const Text(
                  'User Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data['name'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data['email'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Age: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data['age'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SOSNumber: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data['sosnumber'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(
                  data['soshospital'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SOSHospitalNumber: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data['soshospitalnumber'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
