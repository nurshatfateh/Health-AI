import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'navbar.dart';
import 'home.dart';
import 'nearestambulance.dart';

late String? sosnumber = "123";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstRoute(),
    ),
  );
}

class FirstRoute extends StatelessWidget {
  FirstRoute({super.key});

  FirebaseFirestore? firestore;
  CollectionReference? usersCollection;

  final Map<String, String> ambulanceServices = {
    'mirpur': '+8801712367859',
    'uttara': '+8801778713649',
    'azimpur': '+8801911125156',
    'motijheel': '+8801793162925',
    'shavar': '+8801795695697',
  };
  String locationname = "";

  final String sosMessage =
      'Emergency! Please send an ambulance to my location:';
  final List<String> ambulanceNumbers = ['01729953189'];

  void _sendSOSMessage() async {
    Location location = Location();
    LocationData locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
      return;
    }

    double latitude = locationData.latitude ?? 0.0;
    double longitude = locationData.longitude ?? 0.0;

    double mindistance=99.99;

    if(mindistance > (23.822350-latitude).abs()+(90.365417-longitude).abs()) {
      locationname = "mirpur";
      mindistance =  (23.822350-latitude).abs()+(90.365417-longitude).abs();
    }
    if(mindistance > (23.8667-latitude).abs()+(90.4042-longitude).abs()) {
      locationname = "uttara";
      mindistance =  (23.8667-latitude).abs()+(90.4042-longitude).abs();
    }
    if(mindistance > (23.7298-latitude).abs()+(90.3854-longitude).abs()) {
      locationname = "azimpur";
      mindistance =  (23.7298-latitude).abs()+(90.3854-longitude).abs();
    }
    if(mindistance > (23.73330-latitude).abs()+(90.417458-longitude).abs()) {
      locationname = "motijheel";
      mindistance =  (23.73330-latitude).abs()+(90.417458-longitude).abs();
    }
    if(mindistance > (23.858334-latitude).abs()+(90.266670-longitude).abs()) {
      locationname = "shavar";
      mindistance =  (23.858334-latitude).abs()+(23.858334-longitude).abs();
    }

    String message = '$sosMessage\nLocation: https://maps.google.com/?q=$latitude,$longitude';

    if(locationname == "mirpur") {
      launch('sms:+8801712367859?body=$message');
    }
    if(locationname == "uttara") {
      launch('sms:+8801778713649?body=$message');
    }
    if(locationname == "azimpur") {
      launch('sms:+8801911125156?body=$message');
    }
    if(locationname == "motijheel") {
      launch('sms:+8801793162925?body=$message');
    }
    if(locationname == "shavar") {
      launch('sms:+8801795695697?body=$message');
    }

    for (String number in ambulanceNumbers) {
      await sendSMS(message: message, recipients: [number]);
    }

    print('SOS message sent to ambulance services');
  }

  void _sendPersonalSOS() async {
    Location location = Location();
    LocationData locationData;

    try {
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
      return;
    }

    double latitude = locationData.latitude ?? 0.0;
    double longitude = locationData.longitude ?? 0.0;

    String message = 'I am facing an emergency situation. Please help.\nLocation: https://maps.google.com/?q=$latitude,$longitude';

    launch('sms:$sosnumber?body=$message');
  }

  //late String? sosnumber;

  Future<void> initializeFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    firestore = FirebaseFirestore.instance;
    //rsosnumber = user?.uid;

    final usersCollectionRef = FirebaseFirestore.instance.collection("users");

    final query = usersCollectionRef.where("userId", isEqualTo: user?.uid);

    final querySnapshot = await query.get(); // Execute the query

    sosnumber = "abc";

    if (querySnapshot.docs.isEmpty) {
      // Handle case when no document is found
      print("No user document found with the given userId.");
      return;
    }

    final userDoc = querySnapshot.docs[0];

    // Access the sosnumber field value
    //final sosNumber = userDoc.data()["sosnumber"];
    sosnumber = userDoc.data()["sosnumber"].toString();

    //sosnumber = sosNumber;

    print("sosnumber: $sosnumber");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    initializeFirestore();
    return Scaffold(
      backgroundColor: const Color(0xFF5FB2FF),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
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
                    color: const Color(0xFFB0F1FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 5,
                    right: 5,
                    top: 20,
                  ),
                  height: 290,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        elevation: 5,
                        margin: const EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: InkWell(
                          onTap: () {
                            _sendPersonalSOS();
                          },
                          child: const Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.waving_hand_outlined,
                                size: 50.0,
                                color: Colors.red,
                              ),
                              title: Text(
                                "Press to send SOS",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SOSPage()),
                            // );
                            _sendSOSMessage();
                          },
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: const Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.airport_shuttle_outlined,
                                size: 50.0,
                                color: Colors.red,
                              ),
                              title: Text(
                                "Press for Ambulance",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BaseApp()),
                      );
                    },
                    child: const Text(
                      "Go Home",
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
      drawer: Navbar(),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
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
                      color: const Color(0xFFB0F1FF),
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.only(
                      bottom: 70, left: 5, right: 5, top: 70),
                  height: 435,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: InkWell(
                          onTap: () {},
                          child: const Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                size: 50.0,
                                color: Colors.green,
                              ),
                              title: Text(
                                "SOS Message Was Sent Successfully!",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: const EdgeInsets.all(15.0),

                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
                        child: const Center(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                "Your SOS message has been successfully sent to...\n\nSaved Contact:\n+8801933318385\n\nHospital:\nLabaid Specialized Hospital",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 35, bottom: 0),
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BaseApp()),
                      );
                    },
                    child: const Text(
                      "Go Home",
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
      drawer: Navbar(),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

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
                      borderRadius: BorderRadius.circular(30)),
                  margin:
                      EdgeInsets.only(bottom: 70, left: 5, right: 5, top: 60),
                  height: 495,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          onTap: () {},
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                size: 50.0,
                                color: Colors.green,
                              ),
                              title: Text(
                                "Ambulance has been called successfully!",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.airport_shuttle_outlined,
                            size: 70,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),

                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
                        child: Center(
                          child: ListTile(
                            title: Center(
                              child: Text(
                                "Emergency ambulance has been called from the nearest hospital...\n\nHospital name:\nAsgar Ali Hospital ",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BaseApp()),
                      );
                    },
                    child: Text(
                      "Go Home",
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
      drawer: Navbar(),
    );
  }
}
