import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart';
import 'navbar.dart';
import 'cure.dart';
import 'doc.dart';
import 'my_webview.dart';
import 'sos1.dart';
import 'kit_history.dart';
import 'analytics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => BaseApp(),

        '/doc': (context) => docFirstRoute(),
        '/cure': (context) => cureFirstRoute(),
        '/sos1': (context) => FirstRoute(),
        '/kit_history': (context) => kitFirstRoute(),
        '/profile': (context) =>
            userProfile(userId: 'SIQ80geCKfXfgtdvLzA4'),
      },
    );
  }
}

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  late String uid;
  String? documentID;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> getDocumentId(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').where('userId', isEqualTo: userId).get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;

    if (documents.isNotEmpty) {
      final QueryDocumentSnapshot<Map<String, dynamic>> document = documents.first;
      return document.id;
    } else {
      return "alam";
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    
  }

  void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    setState(() {
      uid = user.uid;
    });
    final documentId = await getDocumentId(uid!); // Add null check for uid
    setState(() {
      documentID = documentId;
    });
    print(uid); // Now you can print uid to the console
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Navbar(),
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
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: GridView(
          
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.8,),
          
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF5FB2FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/detection.png',
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "Prediction Chatbot",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                      title: "Chatbot",
                      selectedUrl: "https://healthcare-bot-ejro3jmwzrdpi.azurewebsites.net/",
                    )
                ));
              },
            ),
            InkWell(
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF5FB2FF),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/doctor_suggestion.png',
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "Doctor Suggestion",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
                ],),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => docFirstRoute()),
                  );
              },
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF5FB2FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/cure_suggestion.png',
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "Cure Suggestion",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
                ],),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => cureFirstRoute()),
                  );
              },
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF5FB2FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/data.png',
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "Health Analytics",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
                ],),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => analyticsFirstRoute()),
                  );
              },
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF5FB2FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/profile_details.png',
                    height: 120,
                    width: 150,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text(
                      "Personal Data",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.0,
                        color: Colors.white,fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => userProfile(userId: "$documentID")),
                  );
              },
            ),

            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF5FB2FF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'images/emergency.png',
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "Emergency System",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
                ],),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstRoute()),
                  );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}