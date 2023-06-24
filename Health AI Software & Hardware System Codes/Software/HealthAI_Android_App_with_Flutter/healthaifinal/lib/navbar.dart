import 'package:flutter/material.dart';
import 'package:healthai/services/auth.dart';
import 'forgotpass.dart';
import 'home.dart';
import 'kit_history.dart';
import 'profile.dart';
import 'history.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Navbar extends StatelessWidget {
 Navbar({super.key});
  final AuthService _auth = new AuthService();
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('',style: TextStyle(color: Colors.red,fontWeight:FontWeight.bold)),
            accountEmail: Text('',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold)),

            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(
            //     child: Image.asset(
            //       'images/mr_bean.png',
            //       width: 90,
            //       height: 90,
            //       fit: BoxFit.cover,
            //     ),

            //   ),
            // ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('images/nav_png.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          InkWell(
            child: const ListTile(
              leading: Icon(Icons.home, color: Color(0xFF5FB2FF),),
              title: Text('Home', style: TextStyle(color: Color(0xFF5FB2FF),fontWeight: FontWeight.bold),),

            ),
            onTap: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BaseApp()),
                  );
            },
          ),
          // InkWell(
          //   child: const ListTile(
          //     leading: Icon(Icons.account_circle, color: Color(0xFF5FB2FF),),
          //     title: Text('Profile', style: TextStyle(color: Color(0xFF5FB2FF),fontWeight: FontWeight.bold),),
          //     //onTap: () =>
          //   ),
          //   onTap: () {
          //     Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => userProfile(userId: "xMjstJd012gosYT9sLO5")),
          //         );
          //   },
          // ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.exit_to_app, color: Color(0xFF5FB2FF),),
              title: Text('Log Out', style: TextStyle(color: Color(0xFF5FB2FF),fontWeight: FontWeight.bold),),
              //onTap: () =>
            ),
    onTap: () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("email");
    await _auth.signOut();
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => splash()),
    );
    }
          ),




        ],
      ),
    );
  }
}