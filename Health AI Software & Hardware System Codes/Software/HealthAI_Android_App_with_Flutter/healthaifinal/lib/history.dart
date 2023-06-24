import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: historyFirstRoute() ,
  ),
  );
}


class historyFirstRoute extends StatelessWidget {
  const historyFirstRoute({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(


      backgroundColor: Color(0xFF5FB2FF),

      appBar:AppBar(
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

      body:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children:[
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFB0F1FF),borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 0,left: 5,right: 5,top: 0),


                  height: 610,
                  alignment: Alignment.center,

                  child: Column(
                    children: [
                      SizedBox(height: 15.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(12.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          onTap: () {

                          },
                          child: Center(
                            child: ListTile(

                              leading:Icon(Icons.medical_information_outlined ,size:50.0,color: Colors.redAccent,),
                              title: Text("Medical Kit\n History",
                                style: TextStyle(fontSize:20.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),
                              trailing:Icon(Icons.medical_services_outlined,size:50.0,color: Colors.redAccent,),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),
                      SizedBox(height: 20,),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,

                        margin:EdgeInsets.all(15.0),
                        child: new InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Session 1: Nurshat'),
                              content: const Text('\n-> 5th December, 2022 \n-> 7:30PM \n-> Heart rate: 0\n-> Blood pressure: 0\n-> Oxyzen: 0'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Okay'),
                                ),

                              ],
                            ),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: Center(

                            child: ListTile(

                              title: Text("Session 1: Nurshat\n5th December, 2022\n7:30PM",
                                style: TextStyle(fontSize:19.0,color: Colors.black,fontWeight:FontWeight.bold, ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),
                      SizedBox(height: 0,),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,

                        margin:EdgeInsets.all(15.0),
                        child: new InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(

                              title: const Text('Session 2: Jamal'),
                              content: const Text('\n-> 5th December, 2022 \n-> 5:30PM \n-> Heart rate: 0\n-> Blood pressure: 0\n-> Oxyzen: 0'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Okay'),
                                ),

                              ],
                            ),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: Center(

                            child: ListTile(

                              title: Text("Session 2: Jamal\n5th December, 2022\n5:30PM",
                                style: TextStyle(fontSize:19.0,color: Colors.black,fontWeight:FontWeight.bold, ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),

                      SizedBox(height: 0.0,),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,

                        margin:EdgeInsets.all(15.0),
                        child: new InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Session 3: Rifat'),
                              content: const Text('\n-> 4th December, 2022 \n-> 7:40PM \n-> Heart rate: 0\n-> Blood pressure: 0\n-> Oxyzen: 0'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Okay'),
                                ),

                              ],
                            ),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: Center(

                            child: ListTile(

                              title: Text("Session 3: Rifat\n4th December, 2022\n7:40PM",
                                style: TextStyle(fontSize:19.0,color: Colors.black,fontWeight:FontWeight.bold, ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),






                    ],
                  ),
                ),



              ),
              Center(
                child:Container(
                  margin: EdgeInsets.only(top: 45, bottom: 0),
                  child:


                  TextButton(


                    style: ButtonStyle(

                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
                    ),

                    onPressed: () { },

                    child:

                    Text("Go Home",
                      style: TextStyle(fontSize:23.0,color: Colors.white,fontWeight:FontWeight.bold, ),
                    ),
                  ),
                ),
              )





            ],

          )


      ),

      drawer: Navbar(),


    );


  }
}


