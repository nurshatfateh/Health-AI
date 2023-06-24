import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';
import 'home.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';
import 'forgotpass.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

const List<String> list = <String>[
  'Dhaka',
  'Chattogram',
  'Sylhet',
  'Rajshahi',
  'Khulna',
  'Barisal',
  'Rangpur',
  'Mymensingh'
];
late String? val = list.first;
late String phoneNumber = '999';
late String Disval= 'Dhaka';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: docFirstRoute(),
    ),
  );
}


class docFirstRoute extends StatefulWidget {
  const docFirstRoute({super.key});

  @override
  State<docFirstRoute> createState() => _docFirstRouteState();
}

class _docFirstRouteState extends State<docFirstRoute> {

  String dropdownValue = list.first;

  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.reference().child('1XmMCVZa9qDS6PPanqp5qqHgIB3CGQpDLf06bkrcQ9zY');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB0F1FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.only(bottom: 20, left: 5, right: 5, top: 20),
                height: 500,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 13.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      margin: EdgeInsets.all(15.0),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            "Please Select The Specialist & Area:",
                            style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.location_on_outlined),
                      elevation: 100,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          Disval= dropdownValue;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                      color: Colors.white,
                      margin: EdgeInsets.all(15.0),
                      child: Expanded(
                        child: StreamBuilder<DatabaseEvent>(
                          stream: ref.child('Sheet1').onValue,
                          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();

                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.snapshot.value == null) {
                              return Text('No data available');
                            }

                            List<dynamic>? snapshotData = snapshot.data!.snapshot.value as List<dynamic>?;

                            if (snapshotData == null) {
                              return Text('No data available');
                            }

                            List<String> dropdownValues = snapshotData
                                .where((entry) => entry['District'] == dropdownValue)
                                .map((entry) => entry['Specialist'].toString())
                                .toList();

                            return Column(
                              children: [
                                DropdownSearch<String>(
                                  popupProps:
                                  PopupProps.menu(showSelectedItems: true),
                                  items: dropdownValues,
                                  dropdownDecoratorProps:
                                  DropDownDecoratorProps(
                                    dropdownSearchDecoration:
                                    InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      labelText: "Select Here",
                                    ),
                                  ),
                                  onChanged: (data) {
                                    print(data);
                                    val = data;
                                  },
                                  selectedItem: "",
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => docThirdRoute(),
                          ),
                        );
                      },
                      child: const Text('Search'),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BaseApp(),
                          ),
                        );
                      },
                      child: const Text('Return'),
                    ),
                  ],
                ),
              ),
            ),

            /*Expanded(
              child: FirebaseAnimatedList(
                query: ref.child('Sheet1').limitToFirst(5),
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(
                      snapshot.child('Specialist').value.toString(),
                    ),
                  );
                },
              ),
            ),*/

          ],
        ),
      ),
      drawer: Navbar(),
    );
  }
}


class docThirdRoute extends StatelessWidget {

  docThirdRoute({super.key});

  void openPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    try {
      await launch(url);
    } catch (e) {
      throw 'Could not launch phone dialer: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.reference().child('1XmMCVZa9qDS6PPanqp5qqHgIB3CGQpDLf06bkrcQ9zY');

    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB0F1FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 0),
                height: 650,
                alignment: Alignment.center,
                child: Expanded(
                  child: FirebaseAnimatedList(
                    query: ref.child('Sheet1')
                        .orderByChild('Specialist')
                        .equalTo(val),
                    itemBuilder: (context, snapshot, animation, index) {
                      if (snapshot.child('District').value.toString() != Disval) {
                        // Skip the snapshot if the district doesn't match the desired value
                        return SizedBox.shrink();
                      }

                      String phoneNumber = snapshot.child('Appoint number').value.toString();

                      return Column(
                        children: [
                          SizedBox(height: 15.0),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            margin: EdgeInsets.all(12.0),
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => docThirdRoute()),
                                );
                              },
                              child: Center(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.medical_information_outlined,
                                    size: 50.0,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    snapshot.child('Name').value.toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            child: Center(
                              child: ListTile(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Specialist:\t${snapshot.child('Specialist').value.toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\n\nDegree:\t${snapshot.child('Degree').value.toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\n\nAppointment Number:\t${snapshot.child('Appoint number').value.toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        "\n\Address:\t${snapshot.child('Address').value.toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 0.0),
                          /*ElevatedButton(
                            onPressed: () {
                              openPhoneDialer(phoneNumber);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              minimumSize: Size(200.0, 50.0),
                            ),
                            child: Text(
                              "Call Doctor",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*/
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, // Set the desired border color
                                    width: 2.0, // Set the border width
                                  ),
                                  shape: BoxShape.circle, // Set the shape of the container as a circle
                                ),
                                margin: EdgeInsets.only(top: 20, bottom: 0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(

                                        child: IconButton(
                                          iconSize: 50,
                                          color: Colors.black,

                                          icon: const Icon(Icons.call),
                                          onPressed: () {
                                            // String phoneNumber = '+1234567890'; // Replace with the desired phone number
                                            openPhoneDialer(phoneNumber);
                                          },


                                        ),


                                      ),

                                    ],
                                  ),
                                )),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 2.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Navbar(),
    );
  }
}