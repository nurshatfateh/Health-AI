import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'navbar.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: kitFirstRoute() ,
  ),
  );
}
class kitFirstRoute extends StatelessWidget {
  const kitFirstRoute({super.key});
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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children:[
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFB0F1FF),borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 20,left: 5,right: 5,top: 20),


                  height: 500,
                  alignment: Alignment.center,

                  child: Column(
                    children: [
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


                              title: Text("Session 1: Nurshat",
                                style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),

                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),
                      SizedBox(height: 15.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(12.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          // onTap: () {
                            
                          // },
                          child: Center(
                            child: ListTile(


                              title: Text("Session 2: Jamal",
                                style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),

                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),
                      SizedBox(height: 15.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(12.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          // onTap: () {
                            
                          // },
                          child: Center(
                            child: ListTile(


                              title: Text("Session 3: Rifat",
                                style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),

                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),
                      SizedBox(height: 15.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(12.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          child: Center(
                            child: ListTile(


                              title: Text("Session 4: Tausif",
                                style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),

                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),







                    ],
                  ),
                ),



              ),





            ],

          )


      ),

      drawer:  Navbar(),


    );
  }
}


class kitSecondRoute extends StatelessWidget {
  const kitSecondRoute({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(


      backgroundColor: Color(0xFF5FB2FF),

      appBar:AppBar(
        backgroundColor: Color(0xFF0051CB),
        title:Text("      Health AI  ",
          style:TextStyle(fontSize: 35.0,color: Colors.white,fontWeight:FontWeight.bold) ,
        ),
      ) ,

      body:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children:[
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFB0F1FF),borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 0,left: 5,right: 5,top: 0),


                  height: 580,
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

                              leading:Icon(Icons.book ,size:50.0,color: Colors.redAccent,),
                              title: Text("Session 1:\nRifat",
                                style: TextStyle(fontSize:20.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),
                              trailing:Icon(Icons.book,size:50.0,color: Colors.redAccent,),
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
                              content: const Text('Date: 31/12/2022\nTime: 12:51 PM'),

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

                              title: Text("1. Prof. Dr. Fazlur Rahman\n-> Pediatric Gastroenterologist\n-> Asgar Ali Hospital",
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
                              title: const Text('Prof. Dr. Mizanur Rahman'),
                              content: const Text('\n-> Expertise: Gastroenterologist \n-> Hospital: Square Hospital \n-> Address: Dhanmondi, Dhaka\n-> Email: ahsanmbbs@outlook.com\n-> Phone: 01915153468'),

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

                              title: Text("2. Prof. Dr. Ahsanul Rahman\n-> Gastroenterologist\n-> Square Hospital",
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
                              title: const Text('Prof. Dr. Shafik Ahmed'),
                              content: const Text('\n-> Expertise: Medicine Specialist\n-> Hospital: IBN Sina Hospital \n-> Address: Doagonj, Dhaka\n-> Email: ahmedshaf@outlook.com\n-> Phone: 01916653468'),

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

                              title: Text("3. Prof. Dr. Shafik Ahmed\n-> Medicine Specialist\n-> IBN Sina Hospital",
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
                  margin: EdgeInsets.only(top: 35, bottom: 0),
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

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),

      ),


    );


  }
}
