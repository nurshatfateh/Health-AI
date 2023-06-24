import 'package:flutter/material.dart';
import 'package:healthai/Register.dart';
import 'package:healthai/services/auth.dart';
import 'email_conformation.dart';
import 'main.dart';
import 'models/loginuser.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget{

  final Function? toggleView;
  SignUp({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp>{

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  final AuthService _auth = AuthService();

  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        } ,
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
      ),);

    final txtbutton =  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>[
        const Text('Already have an account?'),
        TextButton(
          child: const Text(
            'Log In',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => splash()),
            );

          },
        )
      ],);



    final registerButton = Container(
    height: 50,
    padding: const EdgeInsets.fromLTRB(85, 0, 85, 0),
    child: ElevatedButton(
    child: const Text('Sign Up' , style: TextStyle(color: Colors.white ,fontSize:20, ),),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.registerEmailPassword(LoginUser(email: _email.text,password: _password.text));
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
              await verifyEmail();

              Navigator.push(context,
                MaterialPageRoute(builder: (context) => email_conformation()),
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
            autovalidateMode: AutovalidateMode.always,
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
                        'Sign Up',
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

                  registerButton,
                  const SizedBox(height: 25.0),
                  txtbutton,
                  const SizedBox(height: 25.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



