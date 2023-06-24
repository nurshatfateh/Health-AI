import 'package:provider/provider.dart';
import '../home.dart';
import 'package:flutter/material.dart';

import '../models/FirebaseUser.dart';
import 'handler.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<FirebaseUser?>(context);

    if(user == null)
    {
      return Handler();
    }else
    {
      return BaseApp();
    }

  }
}