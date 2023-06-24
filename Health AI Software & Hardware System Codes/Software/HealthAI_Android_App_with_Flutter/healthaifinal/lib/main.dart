import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthai/Register.dart';
import 'SignUp.dart';
import 'home.dart';
import 'forgotpass.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'models/loginuser.dart';
import 'services/auth.dart';
import 'models/FirebaseUser.dart';
import 'screens/wrapper.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?splash():BaseApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext context) {

    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: splash(),
          backgroundColor: Color.fromARGB(1000, 95, 178, 255),
        ),
      ),);

  }

}








class splash extends StatelessWidget {
  const splash({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(


      backgroundColor: Color(0xFF5FB2FF),



      body:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              children:[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF5FB2FF),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/splash.png',
                        height: 550,
                        width: 550,
                      ),

                    ],),
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
                      MaterialPageRoute(builder: (context) => Login()
                      ),
                    ),

                    //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    child: Center(

                      child: ListTile(

                        title: Text("Get Started",
                          style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold, ),textAlign: TextAlign.center,
                        ),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                    ),


                  ),),





              ],

            ),
          )


      ),




    );
  }
}












class Login extends StatefulWidget {
  final Function? toggleView;
  Login({this.toggleView});


  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },

        decoration: const InputDecoration(

          errorStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          labelText: 'Email',
          labelStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w900),
          filled: true,
          fillColor: Colors.white70,
        ));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.password),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          suffixIcon: IconButton(
            icon:
            Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          labelText: 'Password',
          labelStyle: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w900),
          filled: true,

          fillColor: Colors.white70,
        ),




    );

    final txtbutton =             Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[
        const Text('Don\'t have any account?'),
        TextButton(
          child: const Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );

          },
        )
      ],);




    final loginEmailPasswordButon =   Container(
    height: 50,
    padding: const EdgeInsets.fromLTRB(85, 0, 85, 0),
    child: ElevatedButton(
    child: const Text('Login' , style: TextStyle(color: Colors.white ,fontSize:20, ),),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {

            dynamic result = await _auth.signInEmailPassword(LoginUser(email: _email.text,password: _password.text));
            if (result.uid == null) { //null means unsuccessfull authentication
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
            }
            else{
              SharedPreferences pref =await SharedPreferences.getInstance();
              pref.setString("email", "useremail@gmail.com");
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => BaseApp()),
              );
            }
          }

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
    );

    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
      resizeToAvoidBottomInset: false,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 60),
                      )

                  ),
                  const SizedBox(height: 35.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox(height: 25.0),


                  loginEmailPasswordButon,

                  const SizedBox(height: 25.0),
                  txtbutton,

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
